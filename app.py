from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({"message": "Agent Owl API is running!"})

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

from flask import Flask, jsonify
import requests
import json

app = Flask(__name__)

# -------------------------------------------------------
# 🔹 ENDPOINT PRINCIPAL
# -------------------------------------------------------

@app.route('/')
def hello():
    return jsonify({"message": "Agent Owl API is running!"})


# -------------------------------------------------------
# 🔹 ENDPOINT DE SALUD
# -------------------------------------------------------

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})


# -------------------------------------------------------
# 🔹 NUEVO ENDPOINT: TEST DE CONEXIÓN OWL → N8N
# -------------------------------------------------------

# URL de tu webhook de producción en n8n (ajústala si cambia el ID)
N8N_WEBHOOK_URL = "https://n8n-clean-evw0.onrender.com/webhook/61a904f2-c40b-47ec-b98b-3b74f7f4d82e"

@app.route('/probar-n8n')
def enviar_tarea_a_n8n():
    """
    Envía una prueba de conexión desde OWL hacia n8n.
    """
    payload = {
        "origen": "agent-owl-api",
        "datos_del_agente": {
            "usuario": "Elver",
            "accion": "prueba de conexión OWL → n8n",
            "mensaje": "Conexión establecida correctamente 🚀"
        }
    }

    headers = {"Content-Type": "application/json"}

    try:
        response = requests.post(N8N_WEBHOOK_URL, json=payload, headers=headers, timeout=10)

        if response.status_code == 200:
            return jsonify({
                "status": "ok",
                "detalle": "✅ Conexión exitosa con n8n",
                "respuesta": response.text
            })
        else:
            return jsonify({
                "status": "error",
                "codigo": response.status_code,
                "respuesta": response.text
            })

    except Exception as e:
        return jsonify({"status": "error", "mensaje": str(e)})


# -------------------------------------------------------
# 🔹 EJECUCIÓN PRINCIPAL
# -------------------------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000, debug=False)

