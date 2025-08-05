[webservers]
%{ for vm in web_hosts ~}
${vm.name} ansible_host=${vm.external_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[databases]
%{ for vm in db_hosts ~}
${vm.name} ansible_host=${vm.external_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[storage]
%{ for vm in storage_hosts ~}
${vm.name} ansible_host=${vm.external_ip} fqdn=${vm.fqdn}
%{ endfor ~}
