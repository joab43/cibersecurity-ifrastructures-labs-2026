<?php
$servername = "ip_db_frutas";
$username = "erp_user";
$password = "1234";
$dbname = "ERP_Frutas";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {"Error: " . $conn->connect_error(); }

echo "Conexion exitosa a la base de datos ERP_Frutas<br>";

$result = $conn->query("SELECT * FROM clientes");
while ($row = $result->fetch_assoc()) {
    echo $row["nombre"] . " - " . $row["email"] . "<br>";
}

$conn->close();
?>

