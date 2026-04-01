from django.shortcuts import render, get_object_or_404, redirect
from decimal import Decimal
from clientes.models import Cliente
from clientes.forms import ClienteForm
from agentes.models import Agente
from aseguradoras.models import Aseguradora
from polizas.models import Tipopoliza, Formapago, Metodopago, Poliza
from core.models import Detalleastp

def crear(request):
    query = request.GET.get('q')
    if query:
        clientes = Cliente.objects.filter(
            id__icontains=query
        ) | Cliente.objects.filter(
            nombre__icontains=query
        ) | Cliente.objects.filter(
            appaterno__icontains=query
        ) | Cliente.objects.filter(
            apmaterno__icontains=query
        ).order_by('nombre', 'appaterno', 'apmaterno')
    else:
        clientes = Cliente.objects.all().order_by('nombre', 'appaterno', 'apmaterno')
    if request.method == 'POST':
        form = ClienteForm(request.POST)
        if form.is_valid():
            cliente = form.save()
            return redirect('crear_agente', cliente_id=cliente.id)
    else:
        form = ClienteForm()
    return render(request, 'crear/crear_cliente.html', {
        'clientes':clientes,
        'form': form
    })

def crear_agente(request, cliente_id):
    cliente = get_object_or_404(Cliente, pk=cliente_id)
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
    return render(request, 'crear/crear_agente.html', {
        'agentes':agentes,
        'cliente':cliente
    })

def crear_aseguradora(request, cliente_id, agente_id):
    cliente = get_object_or_404(Cliente, pk=cliente_id)
    agente = get_object_or_404(Agente, pk=agente_id)
    aseguradoras_relacionadas = Aseguradora.objects.filter(
        detalleagas__agenteid=agente
    ).order_by('nombre')
    aseguradoras = aseguradoras_relacionadas
    return render(request, 'crear/crear_aseguradora.html', {
        'aseguradoras': aseguradoras,
        'agente': agente,
        'cliente': cliente
    })

def crear_tipoPoliza(request, cliente_id, agente_id, aseguradora_id):
    cliente = get_object_or_404(Cliente, pk=cliente_id)
    agente = get_object_or_404(Agente, pk=agente_id)
    aseguradora = get_object_or_404(Aseguradora, pk=aseguradora_id)
    tipoPolizas_relacionadas = Tipopoliza.objects.filter(
        detalleastp__aseguradoraid=aseguradora
    ).order_by('nombre')
    tipoPolizas = tipoPolizas_relacionadas
    return render(request, 'crear/crear_tipoPoliza.html', {
        'tipoPolizas': tipoPolizas,
        'aseguradora': aseguradora,
        'agente': agente,
        'cliente': cliente
    })

def crear_pago(request, cliente_id, agente_id, aseguradora_id, tipoPoliza_id):
    cliente = get_object_or_404(Cliente, pk=cliente_id)
    agente = get_object_or_404(Agente, pk=agente_id)
    aseguradora = get_object_or_404(Aseguradora, pk=aseguradora_id)
    tipoPoliza = get_object_or_404(Tipopoliza, pk=tipoPoliza_id)
    formasPago = Formapago.objects.all()
    metodosPago = Metodopago.objects.all()
    detalleAsTP = get_object_or_404(Detalleastp, aseguradoraid=aseguradora_id, tipopolizaid=tipoPoliza_id)
    comision = detalleAsTP.comision
    if request.method == 'POST':
        id = request.POST.get('id')
        formapago_id = request.POST.get('formapagoid')
        metodopago_id = request.POST.get('metodopagoid')
        prima_base = Decimal(request.POST.get('prima'))
        fechafin = request.POST.get('fechafin')
        porcentaje = Decimal('1') + (comision / Decimal('100'))
        prima_final = prima_base * porcentaje
        Poliza.objects.create(
            id=id,
            aseguradoraid=aseguradora,
            agenteid=agente,
            clienteid=cliente,
            tipopolizaid=tipoPoliza,
            formapagoid_id=formapago_id,
            metodopagoid_id=metodopago_id,
            prima=prima_final,
            fechafin=fechafin
        )
        return redirect('polizas')
    return render(request, 'crear/crear_pago.html', {
        'cliente': cliente,
        'agente': agente,
        'aseguradora': aseguradora,
        'tipoPoliza': tipoPoliza,
        'formasPago': formasPago,
        'metodosPago': metodosPago,
        'comision': comision,
    })