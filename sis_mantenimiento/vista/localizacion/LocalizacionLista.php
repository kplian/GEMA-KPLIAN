<?php
/**
 *@package pXP
 *@file gen-Localizacion.php
 *@author  (rac)
 *@date 14-06-2012 03:46:45
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.LocalizacionLista = Ext.extend(Phx.arbInterfaz, {

		constructor: function(config) {
			this.maestro = config.maestro;
			Phx.vista.LocalizacionLista.superclass.constructor.call(this, config);
			this.init();
			//Inicializa baseParams
			this.baseParams = {};
		},

		onBeforeLoad: function(treeLoader, node) {
			var tiponodo = node.attributes.tipo_nodo;
			treeLoader.baseParams.tipo_nodo = tiponodo;
			if (tiponodo == 'uni_cons' || tiponodo == 'uni_cons_f') {
				treeLoader.baseParams.id_uni_cons = node.attributes.id_uni_cons;
			}
			Phx.vista.LocalizacionLista.superclass.onBeforeLoad.call(this, treeLoader, node)
		},

		Atributos: [{
			//configuracion del componente
			config: {
				labelSeparator: '',
				inputType: 'hidden',
				name: 'id_localizacion'
			},
			type: 'Field',
			form: true
		}, {
			config: {
				name: 'id_localizacion_fk',
				inputType: 'hidden',
				labelSeparator: ''

			},
			type: 'Field',
			form: true
		}, {
			config: {
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength: 30
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.codigo',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 10
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.estado_reg',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: false
		}, {
			config: {
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength: 150
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.nombre',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'ubicacion',
				fieldLabel: 'Ubicación',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 500
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.ubicacion',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'latitud',
				fieldLabel: 'Latitud',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 200
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.latitud',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'longitud',
				fieldLabel: 'Longitud',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 200
			},
			type: 'TextField',
			filters: {
				pfiltro: 'loc.longitud',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'coordenadas',
				fieldLabel: 'Zoom',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 200
			},
			type: 'NumberField',
			filters: {
				pfiltro: 'loc.coordenadas',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'desc_ubicacion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 2000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'loc.desc_ubicacion',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}, {
			config: {
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength: 4
			},
			type: 'NumberField',
			filters: {
				pfiltro: 'usu1.cuenta',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: false
		}, {
			config: {
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer: function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type: 'DateField',
			filters: {
				pfiltro: 'loc.fecha_reg',
				type: 'date'
			},
			id_grupo: 1,
			grid: true,
			form: false
		}, {
			config: {
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength: 4
			},
			type: 'NumberField',
			filters: {
				pfiltro: 'usu2.cuenta',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: false
		}, {
			config: {
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer: function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type: 'DateField',
			filters: {
				pfiltro: 'loc.fecha_mod',
				type: 'date'
			},
			id_grupo: 1,
			grid: true,
			form: false
		},
		{
			config: {
				name: 'tipo_numeracion',
				fieldLabel: 'Numeración de',
				anchor: '70%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'tlocalizacion__cod_form'
					}
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'loc.tipo_numeracion',type:'string'},
			grid: true,
			form: true
		},],
		title: 'Localizacion',
		ActSave: '../../sis_mantenimiento/control/Localizacion/insertarLocalizacion',
		ActDel: '../../sis_mantenimiento/control/Localizacion/eliminarLocalizacion',
		ActList: '../../sis_mantenimiento/control/Localizacion/listarLocalizacionArb',
		id_store: 'id_localizacion',
		textRoot: 'Raíz',
		id_nodo: 'id_localizacion',
		id_nodo_p: 'id_localizacion_fk',
		fwidth: 450,
		fields: ['id', 'tipo_meta', {
			name: 'id_localizacion',
			type: 'numeric'
		}, {
			name: 'codigo',
			type: 'string'
		}, {
			name: 'estado_reg',
			type: 'string'
		}, {
			name: 'nombre',
			type: 'string'
		}, {
			name: 'id_localizacion_fk',
			type: 'numeric'
		}, {
			name: 'ubicacion',
			type: 'string'
		}, {
			name: 'coordenadas',
			type: 'string'
		}, {
			name: 'desc_ubicacion',
			type: 'string'
		}, {
			name: 'id_usuario_reg',
			type: 'numeric'
		}, {
			name: 'fecha_reg',
			type: 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name: 'id_usuario_mod',
			type: 'numeric'
		}, {
			name: 'fecha_mod',
			type: 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name: 'usr_reg',
			type: 'string'
		}, {
			name: 'usr_mod',
			type: 'string'
		},'tipo_numeracion'],
		sortInfo: {
			field: 'id_localizacion',
			direction: 'ASC'
		},
		bdel: false,
		bedit:false,
		bsave: false,
		bnew:false,
		rootVisible: true,

		//Función que se dispara cuando se deselecciona el nodo
		liberaMenu: function(n) {
			Phx.vista.LocalizacionLista.superclass.liberaMenu.call(this, n);
		},

		//Función que se dispara cuando se hace click sobre algún nodo del árbol
		preparaMenu: function(n) {
			//llamada a la clase padre
			Phx.vista.LocalizacionLista.superclass.preparaMenu.call(this, n);
		},

		EnableSelect: function(n) {
			Phx.vista.LocalizacionLista.superclass.EnableSelect.call(this, n)
		},

		getNombrePadre: function(n) {
			var direc
			var padre = n.parentNode;

			if (padre) {
				if (padre.attributes.id != 'id') {
					direc = n.attributes.nombre + ' - ' + this.getNombrePadre(padre)
					return direc;
				} else {
					return n.attributes.nombre;
				}
			} else {
				return undefined;
			}
		}
	
})
</script>

