# Pets-PW1-Teoria
paso 1: Copiar este comando para crear la imagen.

docker build -t mypets .

paso 2: copiar este comando para crear el contenerdor.

docker run -d --name myserver -p 8088:80 mypets
