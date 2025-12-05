#!/bin/bash
# genera un index.html con descripción, audios y PDFs

OUTPUT="index.html"
AUDIO_DIR="audio"
PDF_DIR="sheets"

echo "generando $OUTPUT ..."

cat > $OUTPUT <<EOF
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8" />	
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Mirage – reflexión sobre la creatividad y la inteligencia artificial</title>
  <style>
    body {
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
      color: #222;
      background: #fafafa;
      margin: 0;
      padding: 0;
    }
    header {
      background: #111;
      color: #fff;
      padding: 2rem 1rem;
      text-align: center;
    }
    header h1 {
      margin: 0;
      font-size: 2rem;
      letter-spacing: 0.5px;
    }
    main {
      max-width: 900px;
      margin: 40px auto;
      padding: 0 1.2rem;
      line-height: 1.7;
    }
    h2 {
      border-bottom: 2px solid #ddd;
      padding-bottom: 0.3rem;
      margin-top: 2.5rem;
    }
    p {
      text-align: justify;
    }
    .audio-item, .pdf-item {
      margin-bottom: 1.5rem;
    }
    audio {
      width: 100%;
      margin-top: 0.5rem;
    }
    a.pdf-link {
      text-decoration: none;
      font-weight: 600;
      color: #0056b3;
    }
    a.pdf-link:hover {
      text-decoration: underline;
    }
    .footer {
      margin-top: 60px;
      padding: 1.5rem;
      text-align: center;
      font-size: 0.9rem;
      color: #666;
      border-top: 1px solid #ddd;
    }
    .footer a {
      color: #0056b3;
      text-decoration: none;
    }
    .footer a:hover {
      text-decoration: underline;
    }
    .description {
      background: #fff;
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
  </style>
</head>
<body>
  <header>
    <h1>Mirage – una reflexión sobre la creatividad y la inteligencia artificial</h1>
  </header>

  <main>
    <section class="description">
      <p>La obra plantea una reflexión sobre los límites de la creatividad en la era de la inteligencia artificial y, en particular, sobre el fenómeno de las llamadas “alucinaciones” de los modelos de lenguaje y generación automatizada. Estas alucinaciones, entendidas como errores o desbordamientos en la lógica de la máquina, evidencian que los sistemas algorítmicos no comprenden, sino que simulan comprensión; no crean, sino que calculan posibilidades.</p>

      <p>En la instalación se presenta un simple código QR sostenido por un atril, que permite el acceso a la creación de partituras con Mirage-Phi, un gran modelo de lenguaje (LLM) entrenado para crear música. Junto a éste, se exhiben algunas partituras generadas por este modelo junto con los mockups midi creados mediante intervención humana. Estos dispositivos almacenados en la digitalidad nos muestran un exceso de producción simbólica, una tentativa de composición que podría ser generada por un modelo capaz de producir cientos de piezas por segundo.</p>

      <p>El gesto de mantener los resultados generados por este modelo en un estado digital representa una suerte de limbo entre la música y el silencio, traduciendo la tensión entre la abundancia digital y la experiencia humana finita de la atención. Nos recuerda que, incluso en el contexto tecnológico, la obra sigue dependiendo de la percepción, del tiempo y del cuerpo que la contempla.</p>

      <p>En su conjunto, la pieza intenta cuestionar la noción de autoría y de obra: si la máquina puede generar infinitas variaciones, ¿qué lugar ocupa el compositor, el oyente o incluso la idea de originalidad? La instalación no ofrece respuestas, sino que expone el absurdo y la fascinación de un sistema creativo que produce más de lo que podemos percibir, escuchar o imaginar.</p>

      <p style="margin-top:1.5rem;">👉 Acceso al modelo en Hugging Face:
      <a href="https://huggingface.co/spaces/atsintli/mirage_phi_model-Q8_0.gguf" target="_blank">
        Mirage-Phi Model en Hugging Face
      </a></p>
    </section>

    <section>
      <h2>🎵 audios</h2>
EOF

# recorrer los archivos de audio
for f in $AUDIO_DIR/*.{mp3,ogg,wav,m4a}; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  nombre="${base%.*}"
  tipo=$(file --mime-type -b "$f")

  cat >> $OUTPUT <<EOF
      <div class="audio-item">
        <strong>${nombre}</strong>
        <audio controls>
          <source src="$f" type="$tipo">
          Tu navegador no soporta el elemento de audio.
        </audio>
      </div>
EOF
done

# PDFs
cat >> $OUTPUT <<EOF
    </section>
    <section>
      <h2>📄 documentos PDF</h2>
EOF

for f in $PDF_DIR/*.pdf; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  nombre="${base%.*}"

  cat >> $OUTPUT <<EOF
      <div class="pdf-item">
        <a class="pdf-link" href="$f" target="_blank">${nombre}.pdf</a>
      </div>
EOF
done

# cierre del HTML
cat >> $OUTPUT <<EOF
    </section>

    <section style="margin-top:60px; text-align:center;">
      <img src="images/header.jpg" alt="encabezado del proyecto" style="max-width:100%; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,0.1);" />
    </section>

    <div class="footer">
      <p>sitio publicado con GitHub Pages · contacto: <a href="mailto:atsintli@riseup.net">atsintli@riseup.net</a></p>
    </div>
  </main>
</body>
</html>
EOF

echo "✅ archivo $OUTPUT generado correctamente."
