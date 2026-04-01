from django.shortcuts import render
from .models import Agente

def agentes(request):
    query = request.GET.get('q')
    if query:
        agentes = Agente.objects.filter(
            id__icontains=query
        ) | Agente.objects.filter(
            nombre__icontains=query
        ) | Agente.objects.filter(
            apellidopaterno__icontains=query
        ) | Agente.objects.filter(
            apellidomaterno__icontains=query
        ).order_by('nombre', 'apellidopaterno', 'apellidomaterno')
    else:
        agentes = Agente.objects.all().order_by('nombre', 'apellidopaterno', 'apellidomaterno')
    return render(request, "agentes/agentes.html", {'agentes':agentes})