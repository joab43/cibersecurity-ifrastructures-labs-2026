#!/bin/bash
set -euo pipefail
# ---------------------------------------------------------------
# backup.sh - Sistema de respaldos automáticos cifrados
# Servidor origen: db-frutas
# Servidor destino (NAS) (usuario: nas_user)
# ---------------------------------------------------------------

# === VARIABLES PRINCIPALES ===
BACKUP_BASE="/var/opt/Respaldo"
LOG_DIR="${BACKUP_BASE}/logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="${BACKUP_BASE}/backups-sent_${TIMESTAMP}"
REMOTE_USER="nas_user"
REMOTE_HOST="ip_servidor_nas_frutas"
REMOTE_PATH="/var/opt/RespaldoHistorico/${TIMESTAMP}"
SSH_KEY="/root/.ssh/id_rsa_backup"
PASS_FILE="/root/.backup_pass"
LOGFILE="${LOG_DIR}/backup_${TIMESTAMP}.log"
MYSQL_CNF="/root/.my.cnf"

# Crear carpetas locales necesarias
mkdir -p "${BACKUP_DIR}" "${LOG_DIR}"
echo "[$(date +"%F %T")] Inicio de respaldo en DB-FRUTAS" | tee -a "${LOGFILE}"

# === 1) SINCRONIZACIÓN NTP ===
if command -v chronyc >/dev/null 2>&1; then
  echo "Sincronizando hora con NTP (chrony)..." | tee -a "${LOGFILE}"
  chronyc -a makestep || echo "⚠️ No se pudo sincronizar con chrony" | tee -a "${LOGFILE}"
else
  echo "⚠️ chrony no disponible, continuando sin sincronización" | tee -a "${LOGFILE}"
fi

# === 2) OBTENER BASES DE DATOS EXISTENTES ===
DBS=$(mysql --defaults-file=${MYSQL_CNF} -e 'SHOW DATABASES;' -s --skip-column-names | grep -Ev "^(information_schema|performance_schema|mysql|sys)$" || true)

if [ -z "${DBS}" ]; then
  echo "No se encontraron bases de datos para respaldar." | tee -a "${LOGFILE}"
  exit 0
fi

# === 3) RESPALDAR BASES DE DATOS ===
for DB in ${DBS}; do
  echo "Respaldando base de datos: ${DB}" | tee -a "${LOGFILE}"
  mysqldump --defaults-file=${MYSQL_CNF} --databases "${DB}" > "${BACKUP_DIR}/${DB}.sql"
done

# === 4) CIFRAR LOS RESPALDOS (.sql → .enc) ===
PASS=$(cat "${PASS_FILE}")
for f in "${BACKUP_DIR}"/*.sql; do
  ENC="${f}.enc"
  echo "Cifrando ${f}" | tee -a "${LOGFILE}"
  openssl enc -aes-256-cbc -pbkdf2 -salt -in "${f}" -out "${ENC}" -pass pass:"${PASS}"
  shred -u "${f}"  # elimina el archivo sin cifrar
done

# === 5) ENVIAR ARCHIVOS CIFRADOS AL NAS ===
echo "Enviando respaldos cifrados a NAS (${REMOTE_USER}@${REMOTE_HOST})..." | tee -a "${LOGFILE}"

# Crear carpeta remota en NAS
ssh -i "${SSH_KEY}" -o StrictHostKeyChecking=no "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p '${REMOTE_PATH}'"

# Enviar archivos cifrados mediante rsync (seguro, sin contraseña)
rsync -avz -e "ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no" "${BACKUP_DIR}/" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/"

echo "Respaldo completado exitosamente a las $(date +"%T")." | tee -a "${LOGFILE}"

# === 6) LIMPIEZA AUTOMÁTICA ===
# Elimina respaldos locales antiguos (más de 7 días)
find "${BACKUP_BASE}" -maxdepth 1 -type d -name 'backups-sent_*' -mtime +7 -exec rm -rf {} \;
# Elimina logs viejos (más de 30 días)
find "${LOG_DIR}" -type f -name 'backup_*.log' -mtime +30 -delete