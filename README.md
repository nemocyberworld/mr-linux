
# 🧠 Mr Linux: Become a Terminal Titan

**Mr Linux** is a gamified, interactive Bash learning platform designed to make you *love* the terminal. Whether you're a beginner or a seasoned hacker, Mr Linux will sharpen your command-line skills through structured lessons, hands-on practice, and a challenging terminal-based game.

> 🔧 Built by [Captain Nemo](https://github.com/nemcyberworld)
>
> 📬 [nemo14398@gmail.com](mailto:nemo14398@gmail.com)
>
> 🗓️ Last Updated: 20-04-2025
>
> 🌐 Website: [nemocyberworld.github.io](https://nemocyberworld.github.io/)

---

## 🧭 Project Structure

```
mr-linux/
├── main.sh                # Entry point for the learning interface
├── config.sh              # Global configuration
├── lessons/               # Structured topics and subtopics
│   ├── 01. Intro/
│   ├── 02. File & Directory Management/
│   ├── ...
│   └── 16. Gaming Time/   # Bash-based Mr Linux Game
└── README.md
```

---

## 🚀 Features

* 🧪 **250+ interactive Bash lessons**
* 📁 Categorized by real Linux topics
* 🎮 A gamified Linux challenge mode with 23 levels
* 🧠 Learn by doing: `awk`, `sed`, `grep`, permissions, networking, scripting, and more
* ✅ Tracks your learning and progress
* 💻 Written 100% in Bash – no external dependencies

---

## 🎓 Lesson Categories

| #  | Topic                               |
| -- | ----------------------------------- |
| 01 | Intro to Linux & Shell              |
| 02 | File & Directory Management         |
| 03 | Searching & Filtering               |
| 04 | Package Management (Debian & Arch)  |
| 05 | Network Commands                    |
| 06 | Process Management                  |
| 07 | Disk Usage & Storage                |
| 08 | Archiving & Compression             |
| 09 | Task Management & Scheduling        |
| 10 | Users, Groups, and Permissions      |
| 11 | System Info & Hardware              |
| 12 | System Cleanup & Monitoring         |
| 13 | Cryptography & Hashing              |
| 14 | Text Editors                        |
| 15 | Bash Scripting (20 detailed parts)  |
| 16 | 🎮 Gaming Time (The Challenge Game) |

---

## 🎮 Mr Linux Game

Your skills will be tested in the **“Gaming Time”** section — a multi-level Bash-based challenge arena.

🧩 Features:

* 23 handcrafted challenges
* Topics include permissions, searching, scripting, networking, logs, regex, and more
* Progress saved to `~/.mr_linux_save`

🗂️ Example levels:

* `level3_grep_mastery.sh`
* `level10_networking2_nc.sh`
* `level22_fork_bomb.sh`
* `level23_bash_gauntlet.sh`

---

## 🛠️ Getting Started

**Option 1: Install from `.deb`**

```bash
sudo dpkg -i mr-linux.deb   # install
sudo dpkg -r mr-linux       # uninstall
```

**Option 2: Clone the repository**

```bash
git clone https://github.com/nemcyberworld/mr-linux.git
cd mr-linux
bash main.sh
```

**Run individual lessons manually:**

```bash
cd "lessons/02. File & Directory Management/ls"
bash lesson.sh
```

---

## 💾 Save System

Your game progress is stored automatically in:

```bash
~/.mr_linux_save
```

Tracks:

* Completed levels
* Total points

To reset your progress, simply delete the file.

---

## 📬 Contact

* GitHub: [@nemcyberworld](https://github.com/nemcyberworld)
* Email: [nemo14398@gmail.com](mailto:nemo14398@gmail.com)

---

## 📄 License

Licensed under the [MIT License](https://chatgpt.com/c/LICENSE). Contributions welcome!

---

## 🌟 Support Mr Linux

If you find Mr Linux useful or fun:

* ⭐ Star the repo
* 🍴 Fork and add your own lessons
* 🐛 Report issues or suggest improvements
* 📣 Share with fellow Linux learners

---

> *“The shell is my sword, and Bash is my spellbook.”* — Captain Nemo 🐙

---
