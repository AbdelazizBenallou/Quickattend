import requests
import random
import time

url = "https://jaylen-protoplasmatic-kimora.ngrok-free.dev/sum"

while True:
    num1 = random.randint(1, 100)
    num2 = random.randint(1, 100)

    data = {
        "a": num1,
        "b": num2
    }

    try:
        start_time = time.perf_counter()  # High precision timer

        response = requests.post(url, json=data)

        end_time = time.perf_counter()

        latency_ms = (end_time - start_time) * 1000  # Convert to ms

        print(f"Sent: {data}")
        print(f"Status: {response.status_code}")
        print(f"Latency: {latency_ms:.2f} ms")
        print("-" * 40)

    except Exception as e:
        print("Error:", e)

    time.sleep(1)