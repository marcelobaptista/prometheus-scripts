#!/bin/bash

systemctl daemon-reload
systemctl enable --now node_exporter
