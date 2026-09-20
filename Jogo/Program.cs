// Variáveis
var suavida = 100;
var seudano = 25;

var esqueletoVida = 100;
var esqueletoDano = 50;

// Luta
Console.Clear();

while (suavida > 0 & esqueletoVida > 0)
{    
    falar("Esqueleto está na sua frente");
    falar("Você ataca (1) ou foge? (2)");
    var escolha = ouvir();

    if (escolha == "1")
    {
        falar("Você atacou o esqueleto");
        esqueletoVida -= seudano;
    }

    else if (escolha == "2")
    {
        break;
    }

    else
    {
        falar("Comando inválido");
        suavida -= esqueletoDano;
    }
}

// Resolução
if (esqueletoVida <= 0)
{
    falar("Você derrotou o esqueleto");
}

else if (suavida <= 0)
{
    falar("Você foi derrotado");
}

else
{
    falar ("Você fugiu");
}

// Auxílio
static void falar (string parametro)
{
    Console.WriteLine(parametro);
}

static string? ouvir ()
{
    return Console.ReadLine();
}