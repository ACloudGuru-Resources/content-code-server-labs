#!/bin/bash

tee -a /etc/polkit-1/rules.d/service-auth.rules <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.systemd1.manage-units" &&
        subject.user == "cloud_user") {
        return polkit.Result.YES;
    } });
EOF

tee -a /home/cloud_user/.bash_profile <<EOF
systemctl restart code-server@cloud_user
EOF