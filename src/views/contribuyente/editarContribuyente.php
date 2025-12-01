<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
<div class="form1">
  <h1>Editar Contribuyente</h1><hr>

  <form method="POST" action="index.php?c=contribuyente&m=actualizar">
    <input type="hidden" name="id" value="<?= htmlspecialchars($dato['id']) ?>">

    <label>Nombre completo:
      <input type="text" name="nombre" value="<?= htmlspecialchars($dato['nombre']) ?>" required>
    </label><br>

    <label>Genero:
      <select name="genero" required>
        <option value="Hombre" <?= ($dato['genero']=='Hombre')?'selected':'' ?>>Hombre</option>
        <option value="Mujer"  <?= ($dato['genero']=='Mujer')?'selected':'' ?>>Mujer</option>
      </select>
    </label><br>

    <label>Tipo Persona:
      <select name="tipo_persona" required>
        <option value="Natural" <?= ($dato['tipo_persona']=='Natural')?'selected':'' ?>>Natural</option>
        <option value="Juridica" <?= ($dato['tipo_persona']=='Juridica')?'selected':'' ?>>Juridica</option>
      </select>
    </label><br>

    <label>Estado:
      <select name="estado" required>
        <option value="Activo" <?= ($dato['estado']=='Activo')?'selected':'' ?>>Activo</option>
        <option value="Anulado" <?= ($dato['estado']=='Anulado')?'selected':'' ?>>Anulado</option>
      </select>
    </label><br>

    <label>DNI:
      <input type="text" name="dni" value="<?= htmlspecialchars($dato['dni'] ?? '') ?>" pattern="[0-9]{8}" title="8 dígitos">
    </label><br>

    <label>RUC:
      <input type="text" name="ruc" value="<?= htmlspecialchars($dato['ruc'] ?? '') ?>" pattern="[0-9]{11}" title="11 dígitos">
    </label><br>

    <label>Otro Documento:
      <select name="otro_documento_identidad">
        <option value="" <?= empty($dato['otro_documento_identidad']) ? 'selected' : '' ?>>--Seleccione--</option>
        <option value="Libreta Militar" <?= ($dato['otro_documento_identidad']=='Libreta Militar')?'selected':'' ?>>Libreta Militar</option>
        <option value="Pasaporte" <?= ($dato['otro_documento_identidad']=='Pasaporte')?'selected':'' ?>>Pasaporte</option>
        <option value="Carnet de Extranjeria" <?= ($dato['otro_documento_identidad']=='Carnet de Extranjeria')?'selected':'' ?>>Carnet de Extranjeria</option>
        <option value="Partida de Nacimiento" <?= ($dato['otro_documento_identidad']=='Partida de Nacimiento')?'selected':'' ?>>Partida de Nacimiento</option>
      </select>
    </label><br>

    <label>Nro Documento:
      <input type="text" name="nro_documento_identidad" value="<?= htmlspecialchars($dato['nro_documento_identidad'] ?? '') ?>">
    </label><br>

    <label>Fecha Nacimiento:
      <input type="date" name="fecha_nacimiento" value="<?= htmlspecialchars($dato['fecha_nacimiento'] ?? '') ?>">
    </label><br>

    <label>Domicilio Fiscal:
      <input type="text" name="domicilio_fiscal" value="<?= htmlspecialchars($dato['domicilio_fiscal'] ?? '') ?>">
    </label><br>

    <label>Telefono Celular:
      <input type="text" name="telefono_celular" value="<?= htmlspecialchars($dato['telefono_celular'] ?? '') ?>" pattern="[0-9]{9}" title="9 dígitos">
    </label><br>

    <label>Email:
      <input type="email" name="email" value="<?= htmlspecialchars($dato['email'] ?? '') ?>">
    </label><br>

    <label>Observaciones:
      <textarea name="observaciones" rows="4" cols="50"><?= htmlspecialchars($dato['observaciones'] ?? '') ?></textarea>
    </label><br>

    <input type="submit" class="btn" value="ACTUALIZAR">
  </form>
</div>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>