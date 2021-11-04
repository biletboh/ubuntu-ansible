# Custom initial desktop Ubuntu setup

Install ansible to run the setup:
```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
ansible-galaxy collection install community.general
```


Set up localhost invetory in `/etc/ansible/hosts`:
```
localhost              ansible_connection=local
```

Run ansible playbook to update system:

```
ansible-playbook setup.yml -l localhost
```
