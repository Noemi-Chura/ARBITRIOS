<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
<div class="form1">
  <h1>Editar Predio</h1><hr>

  <form method="POST" action="index.php?c=predio&m=actualizar">
    <input type="hidden" name="id" value="<?= $dato['id'] ?>">

    <label>Estado:
      <select name="estado" required>
        <option value="Activo" <?= $dato['estado']=='Activo'?'selected':'' ?>>Activo</option>
        <option value="Anulado" <?= $dato['estado']=='Anulado'?'selected':'' ?>>Anulado</option>
        <option value="Subdividido" <?= $dato['estado']=='Subdividido'?'selected':'' ?>>Subdividido</option>
      </select>
    </label><br>

    <label>Vía:
      <select name="id_via">
        <option value="">--Seleccione--</option>
        <?php foreach ($vias as $via): ?>
          <option value="<?= $via['id'] ?>" <?= $via['id']==$dato['id_via']?'selected':'' ?>><?= htmlspecialchars($via['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Sector:
      <select name="id_sector">
        <option value="">--Seleccione--</option>
        <?php foreach ($sectores as $sector): ?>
          <option value="<?= $sector['id'] ?>" <?= $sector['id']==$dato['id_sector']?'selected':'' ?>><?= htmlspecialchars($sector['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Habilitación Urbana:
      <select name="id_habilitacion_urbana" required>
        <option value="">--Seleccione--</option>
        <?php foreach ($habilitaciones as $hab): ?>
          <option value="<?= $hab['id'] ?>" <?= $hab['id']==$dato['id_habilitacion_urbana']?'selected':'' ?>><?= htmlspecialchars($hab['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Nombre del Predio:
      <input type="text" name="nombre_predio" value="<?= htmlspecialchars($dato['nombre_predio'] ?? '') ?>" required>
    </label><br>

    <label>Tipo Interior:
      <select name="id_tipo_interior">
        <option value="">--Seleccione--</option>
        <?php foreach ($tipos_interior as $tipo): ?>
          <option value="<?= $tipo['id'] ?>" <?= $tipo['id']==$dato['id_tipo_interior']?'selected':'' ?>><?= htmlspecialchars($tipo['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Número:
      <input type="text" name="numero" value="<?= htmlspecialchars($dato['numero'] ?? '') ?>">
    </label><br>

    <label>Letra:
      <input type="text" name="letra" maxlength="1" value="<?= htmlspecialchars($dato['letra'] ?? '') ?>">
    </label><br>

    <label>Nro Interior:
      <input type="text" name="nro_interior" value="<?= htmlspecialchars($dato['nro_interior'] ?? '') ?>">
    </label><br>

    <label>Manzana:
      <input type="text" name="manzana" value="<?= htmlspecialchars($dato['manzana'] ?? '') ?>">
    </label><br>

    <label>Lote:
      <input type="text" name="lote" value="<?= htmlspecialchars($dato['lote'] ?? '') ?>">
    </label><br>

    <label>Sublote:
      <input type="text" name="sublote" value="<?= htmlspecialchars($dato['sublote'] ?? '') ?>">
    </label><br>

    <label>Bloque:
      <input type="text" name="bloque" value="<?= htmlspecialchars($dato['bloque'] ?? '') ?>">
    </label><br>

    <label>Edificio:
      <input type="text" name="edificio" value="<?= htmlspecialchars($dato['edificio'] ?? '') ?>">
    </label><br>

    <label>Piso:
      <input type="text" name="piso" value="<?= htmlspecialchars($dato['piso'] ?? '') ?>">
    </label><br>

    <label>Otra Numeración:
      <input type="text" name="otra_numeracion" value="<?= htmlspecialchars($dato['otra_numeracion'] ?? '') ?>">
    </label><br>

    <label>Nro Partida:
      <input type="text" name="nro_partida" value="<?= htmlspecialchars($dato['nro_partida'] ?? '') ?>">
    </label><br>

    <label>Departamento:
      <input type="number" name="id_departamento" value="<?= htmlspecialchars($dato['id_departamento'] ?? '') ?>" required>
    </label><br>

    <label>Provincia:
      <input type="number" name="id_provincia" value="<?= htmlspecialchars($dato['id_provincia'] ?? '') ?>" required>
    </label><br>

    <label>Distrito:
      <input type="number" name="id_distrito" value="<?= htmlspecialchars($dato['id_distrito'] ?? '') ?>" required>
    </label><br>

    <input type="submit" class="btn" value="ACTUALIZAR">
  </form>
</div>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>