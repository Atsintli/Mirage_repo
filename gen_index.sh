#!/bin/bash
# genera un index.html que muestra todos los archivos de audio en la carpeta "audios/"

OUTPUT="index.html"
REPO_NAME=""  # cambia este valor por el nombre real de tu repo
AUDIO_DIR="audio"

echo "generando $OUTPUT ..."

# inicio del HTML
cat > $OUTPUT <<EOF
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>mis audios</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 800px; margin: 40px auto; line-height: 1.6; padding: 0 16px; }
    h1, h2 { margin-bottom: 0.5em; }
    .audio-item { margin-bottom: 24px; }
    audio { width: 100%; margin-top: 8px; }
  </style>
</head>
<body>
  <header>
    <h1>mis audios</h1>
    <p>Aquí puedes escuchar directamente los archivos de audio.</p>
  </header>

  <section>
    <h2>lista de reproducción</h2>
EOF

# recorrer los archivos de audio y añadirlos al HTML
for f in $AUDIO_DIR/*.{mp3,ogg,wav,m4a}; do
  [ -e "$f" ] || continue  # salta si no hay coincidencias
  base=$(basename "$f")
  nombre="${base%.*}"  # quitar extensión
  tipo=$(file --mime-type -b "$f")

  cat >> $OUTPUT <<EOF
    <div class="audio-item">
      <strong>${nombre}</strong>
      <audio controls>
        <source src="$REPO_NAME/$f" type="$tipo">
        Tu navegador no soporta el elemento de audio.
      </audio>
    </div>
EOF
done

# cierre del HTML
cat >> $OUTPUT <<EOF
  </section>
  <footer style="margin-top:40px;color:#666;font-size:0.9rem">
    <p>sitio publicado con GitHub Pages</p>
  </footer>
</body>
</html>
EOF

echo "✅ archivo $OUTPUT generado correctamente."
