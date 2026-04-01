from django.shortcuts import render
from django.db.models import Q
from polizas.models import Poliza
from core.models import Detalleagas, Detalleastp

def menu(request):
    return render(request, "reportes/menu.html")

def reporte_polizas(request):
    query = request.GET.get('q')
    if query:
        polizas = Poliza.objects.select_related(
            'clienteid', 'agenteid', 'aseguradoraid', 'tipopolizaid', 'formapagoid', 'metodopagoid'
        ).filter(
            Q(id__icontains=query) |
            Q(clienteid__nombre__icontains=query) |
            Q(clienteid__appaterno__icontains=query) |
            Q(clienteid__apmaterno__icontains=query) |
            Q(agenteid__nombre__icontains=query) |
            Q(agenteid__apellidopaterno__icontains=query) |
            Q(agenteid__apellidomaterno__icontains=query) |
            Q(aseguradoraid__nombre__icontains=query) |
            Q(tipopolizaid__nombre__icontains=query) |
            Q(formapagoid__forma__icontains=query) |
            Q(metodopagoid__metodo__icontains=query)
        ).order_by('fechafin')
    else:
        polizas = Poliza.objects.all().order_by('fechafin')
    return render(request, "reportes/polizas.html", {'polizas':polizas})

def reporte_AgAs(request):
    query = request.GET.get('q')
    if query:
        detalles = Detalleagas.objects.select_related(
            'agenteid', 'aseguradoraid'
        ).filter(
            Q(agenteid__id__icontains=query) |
            Q(agenteid__nombre__icontains=query) |
            Q(agenteid__apellidopaterno__icontains=query) |
            Q(agenteid__apellidomaterno__icontains=query) |
            Q(aseguradoraid__id__icontains=query) |
            Q(aseguradoraid__nombre__icontains=query)
        ).order_by('agenteid__nombre', 'agenteid__apellidopaterno', 'agenteid__apellidomaterno')
    else:
        detalles = Detalleagas.objects.all().order_by('agenteid__nombre', 'agenteid__apellidopaterno', 'agenteid__apellidomaterno')
    return render(request, "reportes/AgAs.html", {'detalles':detalles})

def reporte_AsTP(request):
    query = request.GET.get('q')
    if query:
        detalles = Detalleastp.objects.select_related(
            'aseguradoraid', 'tipopolizaid'
        ).filter(
            Q(aseguradoraid__id__icontains=query) |
            Q(aseguradoraid__nombre__icontains=query) |
            Q(tipopolizaid__id__icontains=query) |
            Q(tipopolizaid__nombre__icontains=query)
        ).order_by('aseguradoraid__nombre', 'tipopolizaid__nombre')
    else:
        detalles = Detalleastp.objects.all().order_by('aseguradoraid__nombre', 'tipopolizaid__nombre')
    return render(request, "reportes/AsTP.html", {'detalles':detalles})