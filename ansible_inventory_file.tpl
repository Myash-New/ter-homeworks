[webservers]
%{ for web in webservers ~}
${web.vm_name} ansible_host=${web.external_ip} fqdn=${web.fqdn}
%{ endfor ~}

[databases]
%{ for db in databases ~}
${db.vm_name} ansible_host=${db.external_ip} fqdn=${db.fqdn}
%{ endfor ~}

[storage]
%{ for store in storages ~}
${store.vm_name} ansible_host=${store.external_ip} fqdn=${store.fqdn}
%{ endfor ~}