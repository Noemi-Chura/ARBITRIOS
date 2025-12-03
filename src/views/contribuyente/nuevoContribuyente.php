<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
<div class="form1">
  <h1>Nuevo Contribuyente</h1><hr>

  <form method="POST" action="index.php?c=contribuyente&m=guardar">

    <label>Nombre completo:
      <input type="text" name="nombre" required>
    </label><br>

    <label>Genero:
      <select name="genero" required>
        <option value="Hombre">Hombre</option>
        <option value="Mujer">Mujer</option>
      </select>
    </label><br>

    <label>Tipo Persona:
      <select name="tipo_persona" required>
        <option value="Natural">Natural</option>
        <option value="Juridica">Juridica</option>
      </select>
    </label><br>

    <label>Estado:
      <select name="estado" required>
        <option value="Activo">Activo</option>
        <option value="Anulado">Anulado</option>
      </select>
    </label><br>

    <label>DNI:
      <input type="text" name="dni" pattern="[0-9]{8}" title="8 dígitos">
    </label><br>

    <label>fecha Nacimiento:
      <input type="date" name="fecha_nacimiento">
    </label><br>

    <label>Domicilio Fiscal:
      <input type="text" name="domicilio_fiscal">
    </label><br>

    <label>Telefono Celular:
      <input type="text" name="telefono_celular" pattern="[0-9]{9}" title="9 dígitos"> 
    </label><br>

    <label>RUC:
      <input type="text" name="ruc" pattern="[0-9]{11}" title="11 dígitos">
    </label><br>

    <label>Otro Documento:
      <select name="otro_documento_identidad">
        <option value="">--Seleccione--</option>
        <option value="Libreta Militar">Libreta Militar</option>
        <option value="Pasaporte">Pasaporte</option>
        <option value="Carnet de Extranjeria">Carnet de Extranjeria</option>
        <option value="Partida de Nacimiento">Partida de Nacimiento</option>
      </select>
    </label><br>

    <label>Nro Documento:
      <input type="text" name="nro_documento_identidad">
    </label><br>

    <label>Email:
      <input type="email" name="email">
    </label><br>

    <label>Observaciones:
      <textarea name="observaciones" rows="4" cols="50"></textarea>
    </label><br>

    <input type="submit" class="btn" value="GUARDAR">
  </form>
</div>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>