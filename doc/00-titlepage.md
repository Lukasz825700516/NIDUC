---
title: "NIDUC - Jednostka arytmetyczna z kodami resztkowymi"
author: "Patryk Hłond, Łukasz Mędrek, Kacper Wróblewski"
header-includes:
  - \usepackage[utf8]{inputenc}
  - \usepackage{graphicx}

output:
    pdf_document
---

\tableofcontents

# NIDUC

Celem projektu jest zaprojektowanie i sprawdzenie odporności na błędy miękkie [1] jednostki 
artmetycznej wykożystującej detekcję błędów za pomocą kodów resztkowych.

zaprojektowana jednostka arytmetyczna ma wspierać co najmniej dodawanie i mnożenie w systemie liczb stało przecinkowych bez znaku, 
z czego dodawanie ma być zaimplementowanie dwa razy przy użyciu różnych układów (np. RCA, CLA).
