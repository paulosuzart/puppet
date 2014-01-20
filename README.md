What is inside
--------------

Usando
------

Basta fazer `include` da classe `developer_role` com os devidos parâmetros.

As seguinte variáveis são **MANDATÓRIAS** para um node:

   - `$user_full_name`. Usada no git
   - `$user_email`. Usada no git
   - `$user_name`. Nome do usuário usado para home e execução de recursos
   - `$user_home`. Usada para instalação

Classe principal `developer_role`:
--------------------------------------------

**Pacotes e ferramentas Opcionais**

   - `postgis       => true,`. Efetua instalação do PostgreSQL
   - `git           => true,`. Efetua instalação do Git e customiações
   - `change_prompt => true,` Configura prompt otimizado para git e svn
   - `lein          => true,`. Instalar leiningen  [Opcional]
   - `gvm           => true,`. Instala GVM [Opcional]

** Pacotes e ferramentas instalados por padrão**

   - class `convenience`. Instala `vim-gtk`, `ack-grep`, `htop`, `kdiff3`, `meld`, `terminator` e `sed`
   - Python + Pip + Virtualenv [Incondicional]   

**Customizações**
  
Criação de bases de dados (requer : `gvm => true`)

    pg_databases  => {
                     'dashboard'       => {owner    => 'dashboard',
                                           password => 'dashboard'},
                     'config'          => {owner => 'dashboard',
                                           password => 'dashboard'},
    }   
   
Criação de Virtualenv e seus pacotes instalados via pip:

    python_virtualenvs => {"$workspace/ENV" => 
                            {packages => 
                              ['setuptools', 
                               'fabric',
                               'python-simple-hipchat']}
    }

GVM Intalação de pacotes (requer : `gvm => true`)

    gvm_packages       => {
                           #groovy versions
                           'groovy'  => {version     => '1.8.8',
                                         is_default  => true},
                           #grails versions
                           'grails'  => {version     => '1.3.7',},
                           'grails'  => {version     => '2.1.5',
                                         is_default  => true},
                           #additional packages
                           'vertx'   => {version     => '2.0.2-final',
                                         is_default  =>  true}
                          },
    }

TODO
-----
   - Permitir acesso à toda rede da máquina no pg_hba - **TODO**
   - Criar role kaufda_developer_role que herda developer_role e clona repositórios, restaura banco - **TODO**
   - Customizar ack-grep - **TODO**
   - Configurar profile minimo leiningen **DONE**
   - Instalar postgis
   - Adicionar possibilidade de ensure present/absent para pacotes python e gvm

IMPORTANT: Dependencies
-----------------------
These manifests depends on the following puppet forge modules:
`puppetlabs/postgresql`
`stankevich/python`
`garethr/docker`


