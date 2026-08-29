# GitHub Actions CI/CD Demo 🚀

A hands-on DevOps project demonstrating Continuous Integration (CI) using GitHub Actions, Python, Git, and automated testing.

## 📌 Project Overview

This project demonstrates how source code can be automatically tested whenever changes are pushed to the main branch.

The workflow uses GitHub Actions to create an Ubuntu-based runner, check out the repository, configure Python, install testing dependencies, and execute automated tests.

## 🛠️ Technologies Used

- Git
- GitHub
- GitHub Actions
- Python
- Pytest
- Linux / Ubuntu
- YAML

## 🏗️ Project Structure

```text
github-actions-demo/
│
├── app.py
├── test_app.py
├── README.md
├── .gitignore
│
└── .github/
    └── workflows/
        └── ci.yml
