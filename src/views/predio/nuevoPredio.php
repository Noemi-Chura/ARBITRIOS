<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
<div class="form1">
  <h1>Nuevo Predio</h1><hr>

  <form method="POST" action="index.php?c=predio&m=guardar">

    <label>Estado:
      <select name="estado" required>
        <option value="Activo">Activo</option>
        <option value="Anulado">Anulado</option>
        <option value="Subdividido">Subdividido</option>
      </select>
    </label><br>

    <label>Vía:
      <select name="id_via">
        <option value="">--Seleccione--</option>
        <?php foreach ($vias as $via): ?>
          <option value="<?= $via['id'] ?>"><?= htmlspecialchars($via['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Sector:
      <select name="id_sector">
        <option value="">--Seleccione--</option>
        <?php foreach ($sectores as $sector): ?>
          <option value="<?= $sector['id'] ?>"><?= htmlspecialchars($sector['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Habilitación Urbana:
      <select name="id_habilitacion_urbana" required>
        <option value="">--Seleccione--</option>
        <?php foreach ($habilitaciones as $hab): ?>
          <option value="<?= $hab['id'] ?>"><?= htmlspecialchars($hab['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Nombre del Predio:
      <input type="text" name="nombre_predio" required>
    </label><br>

    <label>Tipo Interior:
      <select name="id_tipo_interior">
        <option value="">--Seleccione--</option>
        <?php foreach ($tipos_interior as $tipo): ?>
          <option value="<?= $tipo['id'] ?>"><?= htmlspecialchars($tipo['nombre']) ?></option>
        <?php endforeach; ?>
      </select>
    </label><br>

    <label>Número:
      <input type="text" name="numero">
    </label><br>

    <label>Letra:
      <input type="text" name="letra" maxlength="1">
    </label><br>

    <label>Nro Interior:
      <input type="text" name="nro_interior">
    </label><br>

    <label>Manzana:
      <input type="text" name="manzana">
    </label><br>

    <label>Lote:
      <input type="text" name="lote">
    </label><br>

    <label>Sublote:
      <input type="text" name="sublote">
    </label><br>

    <label>Bloque:
      <input type="text" name="bloque">
    </label><br>

    <label>Edificio:
      <input type="text" name="edificio">
    </label><br>

    <label>Piso:
      <input type="text" name="piso">
    </label><br>

    <label>Otra Numeración:
      <input type="text" name="otra_numeracion">
    </label><br>

    <label>Nro Partida:
      <input type="text" name="nro_partida">
    </label><br>

    <label>Departamento:
      <input type="number" name="id_departamento" required>
    </label><br>

    <label>Provincia:
      <input type="number" name="id_provincia" required>
    </label><br>

    <label>Distrito:
      <input type="number" name="id_distrito" required>
    </label><br>

    <input type="submit" class="btn" value="GUARDAR">
  </form>
</div>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>