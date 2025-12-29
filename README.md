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
- ✅ Includes Fluxbox lightweight desktop environment
- ✅ Support for 3D acceleration and graphics extensions

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

### Run the container with Docker

```bash
docker run -d \
  --name wine-desktop \
  -p 5901:5901 \
  -p 8080:8080 \
  -e VNC_USER=myuser \
  -e VNC_PASS=mypass \
  -v $(pwd)/shared:/home/user/shared \
  --shm-size=2g \
  wine-novnc
```

### Or use Docker Compose (recommended)

```bash
# First create a shared directory
mkdir -p shared

# Run with docker-compose
docker-compose up -d
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
| 💾 Shared folder | Mount volume to `/home/user/shared` for file exchange |

---

## 📝 Usage Tips

1. **First Run**: The container will initialize Wine environment which may take 1-2 minutes
2. **File Sharing**: Place Windows executables in the `shared` folder to easily access them
3. **Performance**: The container includes 3D acceleration support for better graphics performance
4. **Persistence**: Wine settings are preserved between container restarts

---

## 📜 License

MIT
