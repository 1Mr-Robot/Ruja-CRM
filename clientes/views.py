from django.shortcuts import render, get_object_or_404, redirect
from .models import Cliente
from .forms import ClienteForm

def clientes(request):
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
    return render(request, "clientes/clientes.html", {'clientes':clientes})
        
def cliente_detalle(request, Cliente_id, modo=None):
    cliente = get_object_or_404(Cliente, id=Cliente_id)

    if request.method == 'GET':
        form = ClienteForm(instance=cliente)
        return render(request, 'clientes/cliente_detalle.html', {
            'cliente': cliente,
            'form': form,
            'modo': modo
        })
    else:
        try:
            form = ClienteForm(request.POST, instance=cliente)
            form.save()
            return redirect('cliente_ver', Cliente_id=Cliente_id)
        except ValueError:
            return render(request, 'clientes/cliente_detalle.html', {
                'cliente': cliente,
                'form': form,
                'modo': 'editar',
                'error': 'Datos inválidos'
            })