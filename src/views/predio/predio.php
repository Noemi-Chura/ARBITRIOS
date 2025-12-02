<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
<a href="index.php?c=predio&m=nuevo" class="btn">NUEVO PREDIO</a>

<table border="1" cellpadding="8" cellspacing="0" style="width:100%; text-align:left;">
    <thead style="background:#eee;">
        <tr>
            <th>ID</th>
            <th>ESTADO</th>
            <th>NOMBRE PREDIO</th>
            <th>NUMERO</th>
            <th>LETRA</th>
            <th>MANZANA</th>
            <th>LOTE</th>
            <th>SUBLLOTE</th>
            <th>BLOQUE</th>
            <th>EDIFICIO</th>
            <th>PISO</th>
            <th>NRO PARTIDA</th>
            <th>Acción</th>
        </tr>
    </thead>
    <tbody>
        <?php if (!empty($dato)): ?>
            <?php foreach ($dato as $row): ?>
                <tr>
                    <td><?= htmlspecialchars($row['id']) ?></td>
                    <td><?= htmlspecialchars($row['estado']) ?></td>
                    <td><?= htmlspecialchars($row['nombre_predio']) ?></td>
                    <td><?= htmlspecialchars($row['numero']) ?></td>
                    <td><?= htmlspecialchars($row['letra']) ?></td>
                    <td><?= htmlspecialchars($row['manzana']) ?></td>
                    <td><?= htmlspecialchars($row['lote']) ?></td>
                    <td><?= htmlspecialchars($row['sublote']) ?></td>
                    <td><?= htmlspecialchars($row['bloque']) ?></td>
                    <td><?= htmlspecialchars($row['edificio']) ?></td>
                    <td><?= htmlspecialchars($row['piso']) ?></td>
                    <td><?= htmlspecialchars($row['nro_partida']) ?></td>
                    <td>
                        <a class="btn" href="index.php?c=predio&m=editar&id=<?= urlencode($row['id']) ?>">Editar</a>
                        <a class="btn" href="index.php?c=predio&m=eliminar&id=<?= urlencode($row['id']) ?>" onclick="return confirm('¿Eliminar este predio?');">Eliminar</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="13" style="text-align:center;">No hay predios registrados</td></tr>
        <?php endif; ?>
    </tbody>
</table>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>