<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
  <a href="index.php?c=contribuyente&m=nuevo" class="btn">NUEVO</a>

  <table border="1" cellpadding="8" cellspacing="0" style="width:100%; text-align:left;">
    <thead style="background:#eee;">
      <tr>
        <th>ID</th>
        <th>ESTADO</th>
        <th>FECHA CREACION</th>
        <th>NOMBRE</th>
        <th>TIPO PERSONA</th>
        <th>GENERO</th>
        <th>FECHA NACIMIENTO</th>
        <th>DOMICILIO FISCAL</th>
        <th>TELEFONO CELULAR</th>
        <th>DNI</th>
        <th>RUC</th>
        <th>Otro Documento</th>
        <th>EMAIL</th>
        <th>OBSERVAIONES</th>
        <th>FECHA CONTROL</th>
        <th>HORA CONTROL</th>
        <th>FECHA SERVIDOR</th>
        <th>Estado</th>
        <th>Acción</th>
      </tr>
    </thead>

    <tbody>
      <?php if (!empty($dato)): ?>
        <?php foreach ($dato as $row): ?>
          <tr>
            <td><?= htmlspecialchars($row["id"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["estado"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["fecha_creacion"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["nombre"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["tipo_persona"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["genero"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["fecha_nacimiento"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["domicilio_fiscal"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["telefono_celular"] ?? "") ?></td>    
            <td><?= htmlspecialchars($row["dni"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["ruc"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["otro_documento_identidad"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["email"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["observaciones"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["f_control"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["h_control"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["fecha_servidor"] ?? "") ?></td>
            <td><?= htmlspecialchars($row["estado"] ?? "") ?></td>
            <td>
              <a class="btn" href="index.php?c=contribuyente&m=editar&id=<?= urlencode($row['id']) ?>">Editar</a>
              <a class="btn" href="index.php?c=contribuyente&m=eliminar&id=<?= urlencode($row['id']) ?>" onclick="return confirm('¿Eliminar este contribuyente?');">Eliminar</a>
              <a class="btn" href="index.php?c=contribuyente&m=editar&id=<?= urlencode($row['id']) ?>">Arbitrios</a>
            </td>
          </tr>
        <?php endforeach; ?>
      <?php else: ?>
        <tr><td colspan="6" style="text-align:center;">No hay contribuyentes registrados</td></tr>
      <?php endif; ?>
    </tbody>
  </table>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>