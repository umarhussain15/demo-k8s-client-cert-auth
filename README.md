# K8s Client certificate authentication and RBAC demo

These bash scripts show client and admin steps needed to setup a user's authentication in kubernetes cluster using "Client certificate authentication. Scripts are numbered to show the order of steps.

Transmission of user's CSR to kubernetes cluster admin is mocked by copying it from user's folder into admin folder.
Similarly the transmission of user's kubeconfig (without user's private key) from admin is mocked by copying the 
kubeconfig from admin to users.

For RBAC the roles folder contains sample `Role` and `ClusterRole`. The role-binding folder contains templates to create RoleBinding one for type User and one for type Group