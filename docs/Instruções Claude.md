# CLAUDE.md — Instruções do Projeto

## Visão Geral do Projeto

Este é um **jogo/multiverso narrativo** desenvolvido em **Godot 4** com **GDScript**. O projeto combina mecânicas de jogo com um universo de histórias interconectadas criadas pelo autor. O Claude atua como parceiro de programação e auxiliar criativo.

---

## Stack e Ambiente

- **Engine:** Godot 4.x
- **Linguagem:** GDScript
- **Versionamento:** Git
- **Colaboradores:** múltiplos — mantenha o código legível e bem comentado

---

## Regras de Código

### Estilo GDScript
- Siga as [convenções oficiais do GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- `snake_case` para variáveis, funções e arquivos
- `PascalCase` para nomes de classes e nós
- `UPPER_SNAKE_CASE` para constantes
- Sempre tipar variáveis e parâmetros: `var health: int = 100`
- Evitar `$NodePath` solto — prefer `@onready var node = $Node`

### Organização
- Um script por responsabilidade — evite scripts "God Object"
- Separe lógica de jogo, narrativa e UI em autoloads/sistemas distintos
- Sinais (`signal`) para comunicação entre nós — evite referências diretas entre cenas
- Prefira composição a herança profunda

### Comentários
- Comente o **porquê**, não o **o quê**
- Funções públicas devem ter docstring resumida
- TODOs no formato: `# TODO(nome): descrição`

---

## Arquitetura do Projeto

```
res://
├── scenes/          # Cenas do Godot (.tscn)
│   ├── worlds/      # Mundos/universos do multiverso
│   ├── characters/  # Personagens jogáveis e NPCs
│   ├── ui/          # Interface e menus
│   └── shared/      # Cenas reutilizáveis
├── scripts/         # Scripts GDScript (.gd)
│   ├── core/        # Sistemas centrais (game loop, save, etc.)
│   ├── narrative/   # Motor narrativo, diálogos, histórias
│   ├── gameplay/    # Mecânicas de jogo
│   └── utils/       # Utilitários e helpers
├── assets/          # Sprites, sons, fontes, etc.
├── data/            # JSONs/recursos de dados (histórias, personagens)
└── autoloads/       # Singletons globais (GameManager, StoryManager, etc.)
```

---

## Sistemas Principais

### StoryManager (Narrativa)
- Gerencia qual história/universo está ativo
- Controla flags de progresso narrativo
- Persiste estado entre sessões via SaveSystem

### GameManager
- Estado global do jogo (cena atual, fase, etc.)
- Transições entre mundos do multiverso

### DialogueSystem
- Sistema de diálogos com suporte a ramificações
- Integrado ao StoryManager para decisões narrativas

---

## Diretrizes para o Claude

### Ao gerar código
- Sempre usar tipagem estática no GDScript
- Preferir `Resource` customizados para dados de história/personagens
- Usar `@export` para variáveis configuráveis no editor
- Emitir sinais ao invés de chamar métodos em outros nós diretamente
- Checar se o nó existe antes de acessar (`if is_instance_valid(node)`)

### Ao sugerir arquitetura
- Considerar que o projeto vai crescer — escalabilidade importa
- Múltiplos colaboradores vão ler o código — clareza > esperteza
- O multiverso implica muitos conteúdos similares — favorecer data-driven design (JSONs, Resources)

### Ao auxiliar na narrativa/criatividade
- Manter consistência com o universo já estabelecido
- Perguntar antes de criar novos personagens ou lore importantes
- Sugestões criativas devem ser marcadas claramente como sugestões

### O que NÃO fazer
- Não refatorar arquivos não solicitados
- Não mudar nomes de nós/cenas sem avisar (quebra referências)
- Não usar `await` sem justificativa clara
- Não criar dependências circulares entre autoloads

---

## Convenções de Commit

```
feat: adiciona sistema de diálogo ramificado
fix: corrige transição entre universos no multiverso
docs: atualiza CLAUDE.md com novos sistemas
refactor: extrai lógica de save para SaveManager
```

---

## Contexto Narrativo

> ⚠️ **Importante:** Este projeto tem um universo próprio em construção. Antes de sugerir mudanças de lore, personagens ou história, consulte os arquivos em `data/` e `docs/lore/` para manter consistência.

### O universo

**Naufrágio** é uma obra sobre um multiverso de mundos interligados — e também o nome de um fenômeno raro dentro das tramas. O multiverso é tratado de forma abstrata como um grande oceano: cada mundo é uma ilha, e como o mar é infinito, cada ilha também é internamente infinita, tornando praticamente impossível que um **Nativo** vá de um mundo a outro por conta própria.

Cada universo possui suas próprias temáticas, estética, regras e criaturas, além de um **Dono**: um ser que governa e representa aquela existência. O **Naufrágio** em si é o nome dado ao fenômeno onde alguém é transportado para outro universo — sem motivo conhecido, por pura coincidência do destino.

### Navegadores

Indivíduos que conseguem burlar a limitação entre mundos são chamados de **Navegadores**, classificados pela forma como chegaram:

- **Náufrago:** transportado por acidente, sem requisito ou condição. É o fenômeno que dá nome à obra.
- **Convocado:** conjurado por um ser de outro mundo, mas mantém vontade e propriedades originais. Pode ou não atender ao chamado.
- **Invocado:** também conjurado, porém geralmente sob controle do Invocador — podendo existir condição ou contrato.
- **Invasor:** veio de forma controlada e consciente. Normalmente mais forte que os Nativos e, na maioria das vezes, com planos de conquistar e subjugá-los.

Navegadores podem ser jogadores, NPCs ou monstros — não necessariamente conscientes. Objetos e estruturas que sofrem Naufrágio ou outra forma de navegação são chamados de **Destroços**.

### Mecânica central

**Naufrágio** é um RPG por turno, sandbox, com progressão levemente roguelike. O objetivo final de cada campanha é completar 100% do mapa ou derrotar o **Dono** do mundo diretamente. Mesmo evitando o confronto, o avanço do jogador o anuncia progressivamente — fazendo o Dono enviar oponentes cada vez mais fortes, ou ir pessoalmente.

**Modos de jogo:**
- **Modo Casual:** o jogador escolhe o mundo e cria seu personagem livremente entre raças e classes já desbloqueadas.
- **Modo Naufrágio:** o mundo, a raça e a classe são definidos pelo jogo — sempre o que o jogador ainda não possui. Só é permitido personalizar gênero e estética. Ao completar a campanha, esses conteúdos são desbloqueados automaticamente.

**Rotas de progressão:**
- **Destruidor:** matar e destruir tudo — NPCs e monstros extintos, cidades devastadas, natureza arrasada.
- **Pacifista:** fazer com que todos os seres e nações se unam a você voluntariamente.
- **Tirano:** obrigar a existência a servir pela força ou dominação.

Ao completar mundos, o jogador desbloqueia recursos para novos personagens: **Mascotes**, **Habilidades**, **Itens**, além de classes e raças.

---

## Dúvidas Frequentes

**Por que Godot 4?**
Escolha do projeto — usar apenas APIs do Godot 4, não do Godot 3.

**Posso usar plugins?**
Sim, mas documente no README e verifique compatibilidade com a versão do Godot em uso.

**Como testar?**
Rodar cenas individuais pelo editor. Sistemas críticos devem ter cenas de teste dedicadas em `scenes/tests/`.
