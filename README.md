# adp
ADP-Rockefeller
#Accessing dev environment
Prerequisites:
 Download putty 
Steps to access the dev environment
1. Open the PuTTYgen program.
2. For Type of key to generate, select SSH-2 RSA.
3. Click the Generate button.
4. Move your mouse in the area below the progress bar. When the progress bar is full, PuTTYgen generates your key pair.
5. Click the Save private key button to save the private key. Warning! You must save the private key. You will need it to connect to your machine.
6. Click the Save public key to save public key with .ppk extension.
7. Share the public key with the client so that they give you permission to the dev environment.
8. Open putty , add the dev environment ip and port.
9. In the same putty , under ssh -Auth section browse to your private key (already saved), click on open and you will be redirected to the dev environment
10. It will prompt you for login use "adp" as login
