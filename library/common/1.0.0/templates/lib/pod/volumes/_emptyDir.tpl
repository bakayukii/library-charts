{{- define "ix.v1.common.controller.volumes.emptyDir" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root }}
- name: {{ tpl (toString $index) $root }}
  {{- if not (or $vol.medium $vol.sizeLimit) }}
  emptyDir: {}
  {{- else }}
  emptyDir:
    {{- with $vol.medium -}}
      {{- if eq (tpl . $root) "Memory" }}
    medium: Memory
      {{- else -}}
        {{- fail (printf "You can only set <medium> as Memory on item (%s)" $index) -}}
      {{- end -}}
    {{- end -}}
    {{- with $vol.sizeLimit }}
    sizeLimit: {{ tpl . $root }}
    {{- end -}}
  {{- end -}}
{{- end -}}