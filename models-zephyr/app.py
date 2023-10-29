from flask import Flask, request, jsonify
from model_copy2 import qa_bot,chat_history
app = Flask(__name__)

Chain = qa_bot()

@app.route('/generateText', methods=['POST'])
def generate_text():
    try:
        data = request.get_json()  
        prompt = data.get('prompt')  
        output=Chain({"question": prompt, "chat_history": chat_history})
        output=output["answer"]
        chat_history.append((prompt,output))
        response = {'output': output}  
    except Exception as e:
        return jsonify({"error" : e})
    return jsonify(response) , 200

@app.route("/ping")
def pon():
    return jsonify({"resp" : "pong"})
app.run(host="0.0.0.0" , port="8080")