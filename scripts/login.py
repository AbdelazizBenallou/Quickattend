import requests
import time

# Configuration
url = "http://localhost:3000/v1/auth/login"  # Update if using ngrok or remote server
email = "ahmed142@gmail.com"
password = "784512963"  # ⚠️ Change this!

total_requests = 10

for i in range(1, total_requests + 1):
    print(f"\n[Attempt {i}/{total_requests}]")
    
    payload = {
        "email": email,
        "password": password
    }

    try:
        start = time.perf_counter()
        response = requests.post(url, json=payload, timeout=10)
        latency_ms = (time.perf_counter() - start) * 1000

        print(f"Status: {response.status_code}")
        print(f"Latency: {latency_ms:.2f} ms")
        
        # Optional: print error message if login fails
        if response.status_code != 200:
            print(f"Response: {response.text}")

    except Exception as e:
        print(f"Error: {e}")

    # Wait 1 second before next attempt
    if i < total_requests:
        time.sleep(1)

print("\n✅ Test completed.")
