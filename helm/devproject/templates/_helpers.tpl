{{/*
Return the chart name.
*/}}
{{- define "devproject.name" -}}
devproject
{{- end -}}

{{/*
Return the full name for this release.
*/}}
{{- define "devproject.fullname" -}}
{{ include "devproject.name" . }}-{{ .Release.Name }}
{{- end -}}
