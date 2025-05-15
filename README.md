# 🐳 Wine Staging + VNC + noVNC in Docker

> A fully working Ubuntu 25.04-based Docker image with **Wine Staging 10**, **TightVNC**, and **noVNC** for browser-based GUI access. Perfect as a lightweight replacement for VPS/VDS with support for running Windows applications inside containers.

---

## 🔧 Features

- ✅ **Ubuntu 25.04 (Plucky)**
- ✅ **WineHQ Staging 10** (latest)
- ✅ **Winetricks** pre-installed
- ✅ **TightVNC Server** for remote desktop
- ✅ **noVNC** for web-based GUI access
- ✅ Dynamic **user/password setup via environment variables**
- ✅ Works out of the box — just build and run
- ✅ Can be used as a base for automated testing or legacy app hosting

---

## 📦 Requirements

- Docker installed
- Internet connection for package installation

---

## 🧪 Build & Run

### Build the image

```bash
docker build -t wine-novnc .
```

### Run the container

```bash
docker run -d \
  --name wine-desktop \
  -p 5901:5901 \
  -p 8080:8080 \
  -e VNC_USER=myuser \
  -e VNC_PASS=mypass \
  wine-novnc
```

---

## 🌐 Access via Web Browser

Open your browser and go to:

```
http://localhost:8080/vnc.html
```

Use your `VNC_PASS` to connect.

You will see a full X11 desktop environment inside the browser 🖥️

---

## 🛠️ Customization

| Feature | How to Use |
|--------|------------|
| 🧑‍💻 Change username | `-e VNC_USER=your_username` |
| 🔒 Change password | `-e VNC_PASS=your_password` |
| 🧰 Add your own .exe | Mount a volume and run `wine /path/to/your.exe` inside the container |
| 📦 Headless mode | Remove GUI tools from Dockerfile if needed |
| ⚙️ Extend functionality | Add more packages in Dockerfile or modify `entrypoint.sh` |

---

## 📸 Screenshot (Optional)

*(Add a screenshot of the VNC desktop in the browser here if you want)*

Example:
![noVNC Desktop](screenshot.png "Wine Desktop via noVNC")

---

## 📜 License

MIT
