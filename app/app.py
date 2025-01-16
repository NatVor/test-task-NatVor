from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

# Configure MySQL connection
db_config = {
    'user': 'webapp_user',
    'password': 'password',
    'host': 'database-vm-ip',
    'database': 'webapp_db'
}

@app.route("/")
def index():
    return "Hello, World! Flask is working with MySQL!"

@app.route("/data")
def get_data():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT 'Test Data from MySQL!'")
        data = cursor.fetchone()
        conn.close()
        return jsonify({'message': data[0]})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
