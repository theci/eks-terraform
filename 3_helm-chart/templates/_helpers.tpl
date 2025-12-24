{{/*
Expand the name of the chart.
*/}}
{{- define "matilda-hdx-helm-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "matilda-hdx-helm-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "matilda-hdx-helm-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "matilda-hdx-helm-chart.labels" -}}
helm.sh/chart: {{ include "matilda-hdx-helm-chart.chart" . }}
{{ include "matilda-hdx-helm-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "matilda-hdx-helm-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "matilda-hdx-helm-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "matilda-hdx-helm-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "matilda-hdx-helm-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common credentials env
*/}}
{{- define "matilda-hdx-helm-chart.secretEnv" -}}            
- name: OPENSEARCH_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.opensearch.secretName }}
      key: username
- name: OPENSEARCH_PWD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.opensearch.secretName }}
      key: password
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.datasource.db1.secretName }}
      key: username
- name: DB_PWD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.datasource.db1.secretName }}
      key: password
{{- if and .Values.aws.secretName }}
- name: AWS_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Values.aws.secretName }}
      key: accesskey
- name: AWS_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.aws.secretName }}
      key: secretkey
{{- end }}
{{- end }}
