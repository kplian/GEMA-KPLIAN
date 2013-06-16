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
	Phx.vista.Localizacion = Ext.extend(Phx.arbInterfaz, {

		constructor: function(config) {
			this.maestro = config.maestro;
			Phx.vista.Localizacion.superclass.constructor.call(this, config);
			this.init();
			//Creación del menú contextual
			this.crearCtxMenu();
			//Adiciona los botones
			this.addBotones();
			//Deshabilita el botón nuevo
			this.tbar.items.get('b-new-' + this.idContenedor).disable()
			//Creación de ventana para agregar Equipos
			this.crearWindowAddEquipo();
			//Creación de ventana para generación y visualización del calendario
			this.crearWindowCalendario();
			//Creación de ventana para generación de reporte ficha técnica más variables
			this.crearWindowRepFichaTecVar();
			//Creación de ventana para gráficos de indicadores
			this.crearWindowGrafInd();
			//Quita la opcion de dmover marcador al cerrar la ventana
			this.window.on('hide', function() {
				Phx.CP.getPagina(this.idContenedor + '-east').marker.setDraggable(false)
			}, this);
			//Inicializa baseParams
			this.baseParams = {};
		},

		onBeforeLoad: function(treeLoader, node) {
			var tiponodo = node.attributes.tipo_nodo;
			treeLoader.baseParams.tipo_nodo = tiponodo;
			if (tiponodo == 'uni_cons' || tiponodo == 'uni_cons_f') {
				treeLoader.baseParams.id_uni_cons = node.attributes.id_uni_cons;
			}
			Phx.vista.Localizacion.superclass.onBeforeLoad.call(this, treeLoader, node)
		},

		onBtnSincUsuUni: function() {
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url: '../../sis_mantenimiento/control/Localizacion/SincronizarUsuarios',
				params: {
					'tarea': 'sincronizar'
				},
				success: this.successSincUsuUni,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		},

		onBtnIncluCalGen: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			//el boton de bloqueo solo se habilita para
			//noso raiz del tipo TUC
			if (data && (data.tipo_nodo == 'rama' || data.tipo_nodo == 'uni_cons_f' || data.tipo_nodo == 'uni_cons')) {
				Phx.CP.loadingShow();
				var aux;
				if (data.incluir_calgen == "false") {
					aux = true;
				} else {
					aux = false;
				}

				Ext.Ajax.request({
					// form:this.form.getForm().getEl(),
					url: '../../sis_mantenimiento/control/UniCons/modificarInclucionGeneracionCalendarioUniCons',
					params: {
						'id_uni_cons': data.id_uni_cons,
						incluir_calgen: aux
					},
					success: this.successIncluCalGen,
					argument: {
						node: node.parentNode
					},
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
		},

		successSincUsuUni: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (!reg.ROOT.error) {
				alert(reg.ROOT.detalle.mensaje)
			} else {
				alert('Se ha producido un error durante el proceso')
			}
		},

		successIncluCalGen: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (!reg.ROOT.error) {
				//alert(reg.ROOT.detalle.mensaje)

			} else {

				alert('ocurrio un error durante el proceso')
			}
			resp.argument.node.reload();

		},

		onCalGen: function() {
			var nodo = this.sm.getSelectedNode();
			if (this.formUCCL.getForm().isValid()) {
				Phx.CP.loadingShow();

				var tiponodo = nodo.attributes.tipo_nodo;
				//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
				var dateFechaFin = this.formUCCL.getForm().findField('fecha_fin');

				if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
					var id_nodo = nodo.attributes.id_uni_cons;
				} else {
					id_nodo = nodo.attributes.id_localizacion;
				}

				var parametros = {
					tipo_nodo : nodo.attributes.tipo_nodo,
					id_localizacion : id_nodo,
					id_uni_cons : nodo.attributes.id_uni_cons,
					//fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
					fecha_fin : dateFechaFin.getValue().dateFormat('d-m-Y')
				};

				Ext.Ajax.request({
					url: '../../sis_mantenimiento/control/UniCons/GenerarCalendario',
					params: parametros,
					success: this.successCalGen,
					argument: parametros,
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}

		},
		onGrafInd: function(){
			var nodo = this.sm.getSelectedNode();
			var id_loc=undefined;
			var id_ucons=undefined;
			if (this.formGrafInd.getForm().isValid()) {
				Phx.CP.loadingShow();
				
				//Obtención del ID con el que se generará el reporte
				var tiponodo = nodo.attributes.tipo_nodo;
				if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
					id_ucons = nodo.attributes.id_uni_cons;
				} else {
					id_loc = nodo.attributes.id_localizacion;
				}
				//console.log(nodo)
				//Obtención de los valores del formulario
				var tipoInd = this.formGrafInd.getForm().findField('tipo'); 
				var mesIni = this.formGrafInd.getForm().findField('mes_ini');
				var mesFin = this.formGrafInd.getForm().findField('mes_fin');
				var gestionIni = this.formGrafInd.getForm().findField('gestion_ini');
				var gestionFin = this.formGrafInd.getForm().findField('gestion_fin');
				var observaciones = this.formGrafInd.getForm().findField('observaciones');

				//Llamada asíncrona al control
				var parametros = {
					tipo_indicador: tipoInd.getValue(),
					id_localizacion: id_loc,
					id_uni_cons: id_ucons,
					mes_ini: mesIni.getValue(),
					mes_fin: mesFin.getValue(),
					gestion_ini: gestionIni.getValue(),
					gestion_fin: gestionFin.getValue(),
					observaciones: observaciones.getValue(),
					codigo: nodo.attributes.codigo,
					nombre:nodo.attributes.nombre,
					padre:nodo.parentNode.attributes.nombre
				};
				//console.log(parametros);
				Ext.Ajax.request({
					url: '../../sis_mantenimiento/control/LocalizacionMed/datosIndicadoresGraf',
					params: parametros,
					//success: this.successGrafInd,
					success: this.successExport,
					argument: parametros,
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
		},
		onCalGenConfirmado: function(parametros) {
			Phx.CP.loadingShow();
			Ext.Ajax.request({
				url: '../../sis_mantenimiento/control/UniCons/GenerarCalendarioConfirmado',
				params: parametros,
				success: this.successCalGen,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		},

		onAddUniCons: function() {
			if (this.formUC.getForm().isValid()) {
				Phx.CP.loadingShow();
				var nodo = this.sm.getSelectedNode();
				var cmbUC = this.formUC.getForm().findField('id_uni_cons');
				var codigo = this.formUC.getForm().findField('codigo_uni_cons');
				var codigo_loc = nodo.parentNode.attributes.codigo + '-' + nodo.attributes.codigo

				Ext.Ajax.request({
					url: '../../sis_mantenimiento/control/UniCons/addUniCons',
					params: {
						id_uni_cons : cmbUC.getValue(),
						codigo_uni_cons : codigo.getValue(),
						id_localizacion : nodo.attributes.id_localizacion,
						codigo_localizacion : codigo_loc,
						nombre : nodo.attributes.nombre
					},
					success: this.successAddUniCons,
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
		},

		successCalGen: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (reg.ROOT.error) {
				alert("ERROR no esperado")
			} else {
				this.wUCCL.hide();
				if (reg.ROOT.datos.generado == 'true') {
					alert("Se incluyeron " + reg.ROOT.datos.contador + " equipos o partes");
				} else {
					if (confirm('La siguientes unidades se perderan: \n' + reg.ROOT.datos.unidades + '\n Desea continuar y sobreescribir esta planificación')) {
						this.onCalGenConfirmado(resp.argument)
					}
				}
			}
		},

		successAddUniCons: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (reg.ROOT.error) {
				alert("ERROR no esperado")
			} else {
				this.wUC.hide();
				var nodo = this.sm.getSelectedNode();
				nodo.reload();
			}
		},
		
		successGrafInd: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			/*if (reg.ROOT.error) {
				alert("ERROR no esperado")
			} else {*/
				this.wGrafInd.hide();
				alert('Datos cargados')
			//}
		},

		onBtnAddEquipo: function() {
			var nodo = this.sm.getSelectedNode();
			this.formUC.form.reset()
			if (nodo) {
				this.wUC.show()
			}
		},

		onBtnCalGen: function() {
			var nodo = this.sm.getSelectedNode();
			if (nodo) {
				this.wUCCL.show()
			}
		},

		onBtnVerCalGen: function() {
			var nodo = this.sm.getSelectedNode();
			if (nodo) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion/gridCalendario.php', 'Calendario de Planificacion', {
					width : 800,
					height : 400
				}, nodo.attributes, this.idContenedor, 'gridCalendario')

			}
		},
		
		onBtnRepCal: function(){
            var nodo = this.sm.getSelectedNode();            
            if(nodo){
                Phx.CP.loadWindows('../../../sis_mantenimiento/vista/calendario_planificado/GenerarReporteCalendario.php',
                        'Calendario de Planificacion',
                        {
                            width:300,
                            height:200
                        },
                        nodo.attributes,this.idContenedor,'GenerarReporteCalendario')
           }
        },

		onBtnUsuario: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_usuario/LocalizacionUsuario.php', 'Usuarios por Localización', {
					modal: true,
					width: 900,
					height: 400
				}, data, this.idContenedor, 'LocalizacionUsuario')
			}
		},

		onBtnMed: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			Phx.CP.log(node);
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_med/LocalizacionMed.php', 'Indicadores: ' + node.text, {
					modal: true,
					width: 900,
					height: 400
				}, data, this.idContenedor, 'LocalizacionMed')
			}
		},
		
		onBtnRepInd : function() {
            var node = this.sm.getSelectedNode();
            var data = node.attributes;
            Phx.CP.log(node);
            if (data) {
                Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_med/GenerarReporteIndicadores.php', 'Reporte Indicadores por Mes' + node.text, {
                    modal : true,
                    width : 900,
                    height : 400
                }, data, this.idContenedor, 'GenerarReporteIndicadores')
            }
        },
        
        onBtnRepAnualInd : function() {
            var node = this.sm.getSelectedNode();
            var data = node.attributes;
            Phx.CP.log(node);
            if (data) {
                Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_med/GenerarReporteAnualIndicadores.php', 'Reporte Anual Indicadores' + node.text, {
                    modal : true,
                    width : 900,
                    height : 400
                }, data, this.idContenedor, 'GenerarReporteAnualIndicadores')
            }
        },
        onBtnRepInvent: function(){
            var node = this.sm.getSelectedNode();
            var data = node.attributes;
            if (data){
                Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons/UniConsInvent.php', 'Inventario Equipos' + node.text, {
                    modal : true,
                    width : 900,
                    height : 400
                }, data, this.idContenedor, 'UniConsInvent')
            }
        },
        onBtnGrafInd: function(){
        	var nodo = this.sm.getSelectedNode();
			if (nodo) {
				this.wGrafInd.show()
			}
        },

		onBtnTPMPorquePorque : function() {
			var rec = this.sm.getSelectedNode();
			var data = rec.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/analisis_porque/AnalisisPorque.php', 'Analisis Porque', {
					modal: true,
					width: 900,
					height: 600
				}, data, this.idContenedor, 'AnalisisPorque')
			}
		},

		onBtnTarjetasTPM: function() {
			var rec = this.sm.getSelectedNode();
			var data = rec.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/tpm_tarjeta/TpmTarjeta.php', 'Control de Tarjetas TPM', {
					modal: true,
					width: 900,
					height: 600
				}, data, this.idContenedor, 'TpmTarjeta')
			}
		},
		
		onConsolEqMed: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			Phx.CP.log(node);
			if (data) {
				var tiponodo = node.attributes.tipo_nodo;
				if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
					var id_nodo = node.attributes.id_uni_cons;
					data.id_uni_cons = id_nodo;
					data.id_localizacion='-1';	
				} else {
					id_nodo = node.attributes.id_localizacion;
					data.id_localizacion = id_nodo;
					data.id_uni_cons='-1';
				}
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_medicion/EquipoMedicionConsol.php', 'Consolidación Mediciones: ' + node.text, {
					modal: true,
					width: 900,
					height: 400
				}, data, this.idContenedor, 'EquipoMedicionConsol')
			}
		},
		onBtnDetConsolMed: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			Phx.CP.log(node);
			if (data) {
				var tiponodo = node.attributes.tipo_nodo;
				if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
					var id_nodo = node.attributes.id_uni_cons;
					data.id_uni_cons = id_nodo;
					data.id_localizacion='-1';
				} else {
					id_nodo = node.attributes.id_localizacion;
					data.id_localizacion = id_nodo;
					data.id_uni_cons='-1';
				}
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_medicion/EquipoMedicionDinamicoLoc.php', 'Detalle Consolidado de Mediciones: ' + node.text, {
					modal: true,
					width: '95%',
					height: '95%'
				}, data, this.idContenedor, 'EquipoMedicionDinamicoLoc')
			}
		},
		winmodal: false,

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
		onButtonNew: function() {
			var nodo = this.sm.getSelectedNode();
			Phx.vista.Localizacion.superclass.onButtonNew.call(this);
			Phx.CP.getPagina(this.idContenedor + '-east').setMarkerDragableOn();
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
		},

		onButtonEdit: function() {
			var nodo = this.sm.getSelectedNode();
			Phx.vista.Localizacion.superclass.onButtonEdit.call(this);
			Phx.CP.getPagina(this.idContenedor + '-east').setMarkerDragableOn();
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
		},

		onButtonDel: function() {
			var nodo = this.sm.getSelectedNode();
			if (nodo.attributes.tipo_nodo == 'uni_cons' || nodo.attributes.tipo_nodo == 'uni_cons_f') {
				nodo.attributes.tipo_meta = nodo.attributes.tipo_nodo;
				nodo.attributes.id_localizacion = nodo.attributes.id_uni_cons;
				//Phx.CP.log('fas',nodo)
			}
			Phx.vista.Localizacion.superclass.onButtonDel.call(this);
			Phx.CP.getPagina(this.idContenedor + '-east').setMarkerDragableOn();
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
		},

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
		east: {
			url: '../../../sis_mantenimiento/vista/localizacion/mapaLocalizacion.php',
			title: 'Ubicación',
			width: '50%',
			cls: 'mapaLocalizacion'
		},
		sortInfo: {
			field: 'id_localizacion',
			direction: 'ASC'
		},
		bdel: true,
		bsave: false,
		rootVisible: true,

		//Función que se dispara cuando se deselecciona el nodo
		liberaMenu: function(n) {
			Phx.vista.Localizacion.superclass.liberaMenu.call(this, n);
			this.menuOp.menu.items.get('btn-verCalGen-' + this.idContenedor).disable();
			this.menuOp.menu.items.get('btn-calGen-' + this.idContenedor).enable();
			this.menuOp.menu.items.get('btn-repCal-' + this.idContenedor).disable();
			this.getBoton('btn-incCalen').disable();
			this.getBoton('btn-addEqu').disable();
			this.menuLoc.menu.items.get('btn-usuSinc-' + this.idContenedor).enable();
			this.menuOp.disable();
		},

		//Función que se dispara cuando se hace click sobre algún nodo del árbol
		preparaMenu: function(n) {
			//Si tiponodo = id => es el nodo raiz que es estático
			//   tiponodo != id => es una localizacion o un unicons
			//             =uni_cons, uni_cons_f
			var tiponodo = n.attributes.tipo_nodo;
			//Si es una nodo tipo carpeta habilitamos el botón nuevo
			if (tiponodo == 'hijo' || tiponodo == 'raiz' || n.attributes.id == 'id') {
				this.tbar.items.get('b-new-' + this.idContenedor).enable()
			} else {
				this.tbar.items.get('b-new-' + this.idContenedor).disable()
			}
			
			if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
				this.tbar.items.get('b-new-' + this.idContenedor).disable()
				this.tbar.items.get('b-edit-' + this.idContenedor).disable()
				//this.tbar.items.get('b-del-'+this.idContenedor).disable()
			}

			//(DES)HABILITACION DE BOTONES Y MENUES
			if (tiponodo == undefined) {
				//****************************************NODO SELECCIONADO: RAIZ
				//AGREGAR EQUIPO
				this.getBoton('btn-addEqu').disable();
				this.ctxMenu.items.get('mni-addEqu-'+this.idContenedor).disable();
				//PLANIFICACION CALENDARIO
				this.menuOp.disable();
				this.menuOp.menu.items.get('btn-verCalGen-' + this.idContenedor).disable();
				this.menuOp.menu.items.get('btn-calGen-' + this.idContenedor).disable();
				this.menuOp.menu.items.get('btn-repCal-' + this.idContenedor).disable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).disable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-verCalGen-' + this.idContenedor).disable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-calGen-' + this.idContenedor).disable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-repCal-' + this.idContenedor).disable();
				//USUARIOS LOCALIZACION
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-usuLoc-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-usuLoc-' + this.idContenedor).disable();
				//INDICADORES
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-indicad-' + this.idContenedor).disable();
				//REPORTE INDICADORES
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-repInd-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-repAnualInd-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-repInvent-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-grafInd-' + this.idContenedor).disable();
				//TARJETAS TPM
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-tarTPM-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-tarTPM-' + this.idContenedor).disable();
				//CONSOLIDACION MEDICIONES
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-consolEqMed-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-consolEqMed-' + this.idContenedor).disable();
				//SINCRONIZACION
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-usuSinc-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-usuSinc-' + this.idContenedor).disable();
				//INCLUIR/EXCLUIR EQUIPOS
				this.getBoton('btn-incCalen').disable();
				this.ctxMenu.items.get('mni-incCalen-' + this.idContenedor).disable();
				//EQUIPOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				//FICHA TÉCNICA
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-ficTec-' + this.idContenedor).disable();
				//MANTENIMIENTOS PREDEFINIDOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-mantPredef-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-mantPredef-' + this.idContenedor).disable();
				//MEDICIÓN DE VARIABLES
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-medVar-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-medVar-' + this.idContenedor).disable();
				//UPLOAD ARCHIVOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-upArch-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-upArch-' + this.idContenedor).disable();
				//TPM ANALISIS PORQUE PORQUE
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).menu.items.get('mni-anPorque-' + this.idContenedor).disable();
				//ANÁLISIS RCM
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmAnalisis-' + this.idContenedor).disable();				
				//PLAN RCM
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmPlan-' + this.idContenedor).disable();
				
			} else if(tiponodo=='uni_cons'||tiponodo=='uni_cons_f'||tiponodo=='rama') {
				//*****************************************NODO SELECCIONADO: EQUIPOS
				//AGREGAR EQUIPO
				this.getBoton('btn-addEqu').disable();
				this.ctxMenu.items.get('mni-addEqu-'+this.idContenedor).disable();
				//PLANIFICACION CALENDARIO
				this.menuOp.enable();
				this.menuOp.menu.items.get('btn-verCalGen-' + this.idContenedor).enable();
				this.menuOp.menu.items.get('btn-calGen-' + this.idContenedor).enable();
				this.menuOp.menu.items.get('btn-repCal-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-verCalGen-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-calGen-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-repCal-' + this.idContenedor).enable();
				//USUARIOS LOCALIZACION
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-usuLoc-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-usuLoc-' + this.idContenedor).disable();
				//INDICADORES
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-indicad-' + this.idContenedor).disable();
				//REPORTE INDICADORES
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-repInd-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-repAnualInd-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-repInvent-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-grafInd-' + this.idContenedor).enable();
				//TARJETAS TPM
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-tarTPM-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-tarTPM-' + this.idContenedor).disable();
				//CONSOLIDACION MEDICIONES
				this.menuLoc.disable();
				//this.ctxMenu.items.get('mni-consolEqMed-' + this.idContenedor).disable();
				//this.menuLoc.menu.items.get('btn-consolEqMed-' + this.idContenedor).disable();
				//SINCRONIZACION
				this.menuLoc.disable();
				this.ctxMenu.items.get('mni-usuSinc-' + this.idContenedor).disable();
				this.menuLoc.menu.items.get('btn-usuSinc-' + this.idContenedor).disable();
				//INCLUIR/EXCLUIR EQUIPOS
				this.getBoton('btn-incCalen').enable();
				this.ctxMenu.items.get('mni-incCalen-' + this.idContenedor).enable();
				//EQUIPOS
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				//FICHA TÉCNICA
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-ficTec-' + this.idContenedor).enable();
				//MANTENIMIENTOS PREDEFINIDOS
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-mantPredef-' + this.idContenedor).enable();
				this.menuEq.menu.items.get('btn-mantPredef-' + this.idContenedor).enable();
				//MEDICIÓN DE VARIABLES
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-medVar-' + this.idContenedor).enable();
				this.menuEq.menu.items.get('btn-medVar-' + this.idContenedor).enable();
				//UPLOAD ARCHIVOS
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-upArch-' + this.idContenedor).enable();
				this.menuEq.menu.items.get('btn-upArch-' + this.idContenedor).enable();
				//TPM ANALISIS PORQUE PORQUE
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).menu.items.get('mni-anPorque-' + this.idContenedor).enable();
				//ANÁLISIS RCM
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmAnalisis-' + this.idContenedor).enable();				
				//PLAN RCM
				this.menuEq.enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmPlan-' + this.idContenedor).enable();
			} else{
				//*****************************************NODO SELECCIONADO: LOCALIZACIONES
				//AGREGAR EQUIPO
				if (tiponodo == 'hijo') {
					this.getBoton('btn-addEqu').enable();
					this.ctxMenu.items.get('mni-addEqu-'+this.idContenedor).enable();
				} else {
					this.getBoton('btn-addEqu').disable();
					this.ctxMenu.items.get('mni-addEqu-'+this.idContenedor).disable();
				}
				//PLANIFICACION CALENDARIO
				this.menuOp.enable();
				this.menuOp.menu.items.get('btn-verCalGen-' + this.idContenedor).enable();
				this.menuOp.menu.items.get('btn-calGen-' + this.idContenedor).enable();
				this.menuOp.menu.items.get('btn-repCal-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-verCalGen-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-calGen-' + this.idContenedor).enable();
				this.ctxMenu.items.get('ctx-PlaMan-' + this.idContenedor).menu.items.get('mni-repCal-' + this.idContenedor).enable();
				//USUARIOS LOCALIZACION
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-usuLoc-' + this.idContenedor).enable();
				this.menuLoc.menu.items.get('btn-usuLoc-' + this.idContenedor).enable();
				//INDICADORES
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-indicad-' + this.idContenedor).enable();
				//REPORTE INDICADORES
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-repInd-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-repAnualInd-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-repInvent-' + this.idContenedor).enable();
				this.ctxMenu.items.get('mni-grafInd-' + this.idContenedor).enable();
				//TARJETAS TPM
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-tarTPM-' + this.idContenedor).enable();
				this.menuLoc.menu.items.get('btn-tarTPM-' + this.idContenedor).enable();
				//CONSOLIDACION MEDICIONES
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-consolEqMed-' + this.idContenedor).enable();
				this.menuLoc.menu.items.get('btn-consolEqMed-' + this.idContenedor).enable();
				//SINCRONIZACION
				this.menuLoc.enable();
				this.ctxMenu.items.get('mni-usuSinc-' + this.idContenedor).enable();
				this.menuLoc.menu.items.get('btn-usuSinc-' + this.idContenedor).enable();
				//INCLUIR/EXCLUIR EQUIPOS
				this.getBoton('btn-incCalen').disable();
				this.ctxMenu.items.get('mni-incCalen-' + this.idContenedor).disable();
				//EQUIPOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				//FICHA TÉCNICA
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-ficTec-' + this.idContenedor).disable();
				//MANTENIMIENTOS PREDEFINIDOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-mantPredef-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-mantPredef-' + this.idContenedor).disable();
				//MEDICIÓN DE VARIABLES
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-medVar-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-medVar-' + this.idContenedor).disable();
				//UPLOAD ARCHIVOS
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-upArch-' + this.idContenedor).disable();
				this.menuEq.menu.items.get('btn-upArch-' + this.idContenedor).disable();
				//TPM ANALISIS PORQUE PORQUE
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-tpm-' + this.idContenedor).menu.items.get('mni-anPorque-' + this.idContenedor).disable();
				//ANÁLISIS RCM
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmAnalisis-' + this.idContenedor).disable();				
				//PLAN RCM
				this.menuEq.disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).disable();
				this.ctxMenu.items.get('mni-equipos-' + this.idContenedor).menu.items.get('mni-rcm-' + this.idContenedor).menu.items.get('mni-rcmPlan-' + this.idContenedor).disable();
			}
			
			//llamada a la clase padre
			Phx.vista.Localizacion.superclass.preparaMenu.call(this, n);
		},

		EnableSelect: function(n) {
			//alert('hola')
			var tiponodo = n.attributes.tipo_nodo;
			if (tiponodo != 'uni_cons_f' && tiponodo != 'uni_cons' && tiponodo != 'rama') {
				var nivel = n.getDepth();
				var direc = this.getNombrePadre(n)
				if (direc) {
					if (Phx.CP.getPagina(this.idContenedor + '-east')) {
						Phx.CP.getPagina(this.idContenedor + '-east').ubicarPos(direc, nivel, n)
					} else {
						alert("No hay acceso a internet")
					}
				}
			} else {
				var nodo_aux;
				if (tiponodo != 'uni_cons' && tiponodo != 'uni_cons_f' && tiponodo == 'rama') {
					nodo_aux = n.parentNode.parentNode
				} else {
					nodo_aux = n.parentNode
				}
				var nivel = nodo_aux.getDepth();
				var direc = this.getNombrePadre(nodo_aux)

				if (direc) {
					if (Phx.CP.getPagina(this.idContenedor + '-east')) {
						Phx.CP.getPagina(this.idContenedor + '-east').ubicarPos(direc, nivel, nodo_aux)
					} else {
						alert("No hay acceso a internet")
					}
				}
			}
			Phx.vista.Localizacion.superclass.EnableSelect.call(this, n)
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
		},

		onFichaTecnicaClick: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Ext.Ajax.request({
					url : '../../sis_mantenimiento/control/UniCons/reporteUniConsFichaTecnica',
					params : {
						'id_uni_cons' : data.id_uni_cons
					},
					success : this.successExport,
					failure : this.conexionFailure,
					timeout : this.timeout,
					scope : this
				});
			}
		},

		onEqMantClick: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_mant_predef/UniConsMantPredef.php', 'Mantenimientos predefinidos [Equipo: ' + data.codigo + '-' + data.nombre + ']', {
					modal : true,
					width : 900,
					height : 400
				}, data, this.idContenedor, 'UniConsMantPredef')

			}
		},

		crearCtxMenu: function() {
			//Grupo de opciones a nivel de localizaciones
			this.ctxMenu.add('-');
			//id:'mnuUsuLoc'+idContenedor,
			this.ctxMenu.addMenuItem({
				id: 'mni-usuLoc-'+this.idContenedor,
				text: 'Usuarios por Localización',
				handler: this.onBtnUsuario,
				scope: this
			});
			this.ctxMenu.addMenuItem({
				id: 'mni-indicad-'+this.idContenedor,
				text: 'Indicadores',
				handler: this.onBtnMed,
				scope: this
			});
			
            this.ctxMenu.addMenuItem({
                id: 'mni-repInd-'+this.idContenedor,
                text : 'Reporte Indicadores por Mes',
                handler : this.onBtnRepInd,
                scope : this
            });
            
            this.ctxMenu.addMenuItem({
                id: 'mni-repAnualInd-'+this.idContenedor,
                text : 'Reporte Anual Indicadores',
                handler : this.onBtnRepAnualInd,
                scope : this
            });
            
            this.ctxMenu.addMenuItem({
                id: 'mni-repInvent-'+this.idContenedor,
                text: 'Reporte Inventario de Equipos',
                handler: this.onBtnRepInvent,
                scope: this
            });
            
            this.ctxMenu.addMenuItem({
                id: 'mni-grafInd-'+this.idContenedor,
                text : 'Gráficos de Indicadores (OITs)',
                handler : this.onBtnGrafInd,
                scope : this
            });
            
			this.ctxMenu.addMenuItem({
				id: 'mni-tarTPM-'+this.idContenedor,
				text: 'Tarjetas TPM',
				handler: this.onBtnTarjetasTPM,
				scope: this
			});

			this.ctxMenu.add('-');			
			this.ctxMenu.addMenuItem({
				id: 'mni-consolEqMed-'+this.idContenedor,
				text: 'Consolidación Mediciones',
				handler: this.onConsolEqMed,
				scope: this
			});
			//Detalle consolidación de mediciones
			this.ctxMenu.addMenuItem({
				id: 'mni-detConsolMed-' + this.idContenedor,
				text: 'Detalle Mediciones Consolidadas',
				handler: this.onBtnDetConsolMed,
				scope: this
			});
			this.ctxMenu.addMenuItem({
				id: 'mni-detFichaTecVar-' + this.idContenedor,
				text: 'Reporte Ficha Técnica Variables',
				handler: this.onBtnFichaTecVar,
				scope: this
			});
			//Sincronización de usuarios
			this.ctxMenu.add('-');
			this.ctxMenu.addMenuItem({
				id: 'mni-usuSinc-' + this.idContenedor,
				text: 'Sincronizar usuarios',
				handler: this.onBtnSincUsuUni,
				scope: this
			});
			//Grupo de opciones para Equipos
			this.ctxMenu.add('-');
			this.ctxMenu.addMenuItem({
				id: 'mni-incCalen-' + this.idContenedor,
				text: 'Incluir/Excluir para Mantenimiento',
				handler: this.onBtnIncluCalGen,
				scope: this
			});
			this.ctxMenu.addMenuItem({
				id: 'mni-addEqu-' + this.idContenedor,
				text: 'Agregar Equipo',
				handler: this.onBtnAddEquipo,
				scope: this
			});
			this.ctxMenu.addMenuItem({
				id:'mni-equipos-'+this.idContenedor,
				text: 'Equipos',
				menu: {
					items: [{
						id:'mni-ficTec-'+this.idContenedor,
						text: 'Ficha Técnica',
						handler: this.onFichaTecnicaClick,
						scope: this
					}, {
						id:'mni-mantPredef-'+this.idContenedor,
						text: 'Mantenimientos predefinidos',
						handler: this.onEqMantClick,
						scope: this
					}, {
						id:'mni-medVar-'+this.idContenedor,
						text: 'Medición de Variables',
						handler: this.onClickMed,
						scope: this
					}, {
						id:'mni-upArch-'+this.idContenedor,
						text: 'Upload archivos',
						handler: this.onClickUp,
						scope: this
					}, {
						id:'mni-tpm-'+this.idContenedor,
						text: 'TPM',
						menu: {
							items: [{
								id:'mni-anPorque-'+this.idContenedor,
								text: 'Análisis Porqué-Porqué',
								handler: this.onBtnTPMPorquePorque,
								scope: this
							}]
						}
					}, {
						id:'mni-rcm-'+this.idContenedor,
						text: 'RCM',
						menu: {
							items: [{
								id:'mni-rcmAnalisis-'+this.idContenedor,
								text: 'Análisis',
								handler: this.onBtnRCMAnalisis,
								scope: this
							}, {
								id:'mni-rcmPlan-'+this.idContenedor,
								text: 'Planificación',
								handler: this.onBtnRCMPlan,
								scope: this
							}]
						}
					}]
				}
			});

			//Grupo de opciones para el Calendario
			this.ctxMenu.add('-');
			this.ctxMenu.addMenuItem({
				id: 'ctx-PlaMan-' + this.idContenedor,
				text: 'Planificación del Mantenimiento',
				menu: {
					items: [
					{
						id: 'mni-calGen-' + this.idContenedor,
						text: 'Generar Calendario',
						handler: this.onBtnCalGen,
						scope: this
					},
					{
						id: 'mni-verCalGen-' + this.idContenedor,
						text: 'Ver Calendario',
						handler: this.onBtnVerCalGen,
						scope: this
					}, 
					{
                        id: 'mni-repCal-' + this.idContenedor,
                        text: 'Reporte Calendario',
                        handler: this.onBtnRepCal,
                        scope: this
                    }]                    
				}
			});
		},

		addBotones: function() {
			this.menuLoc = new Ext.Toolbar.SplitButton({
				id: 'btn-indicad-' + this.idContenedor,
				text: 'Indicadores',
				handler: this.onBtnMed,
				disabled: true,
				scope: this,
				menu:{
				items: [{
					id:'btn-usuLoc-' + this.idContenedor,
					text: 'Usuarios/Localizacion',
					disabled: true,
					tooltip: '<b>Usuarios por Localización</b>',
					handler:this.onBtnUsuario,
					scope: this
				}, {
					id:'btn-usuSinc-' + this.idContenedor,
					text: 'Sincronizar Usuarios',
					disabled: true,
					tooltip: '<b>Sincronizar Usuarios</b>',
					handler:this.onBtnSincUsuUni,
					scope: this
				}, {
					id:'btn-tarTPM-' + this.idContenedor,
					text: 'Tarjetas TPM',
					disabled: true,
					handler: this.onBtnTarjetasTPM,
					tooltip: '<b>Tarjetas TPM</b>',
					scope: this
				}, 
				{
					id:'btn-consolEqMed-' + this.idContenedor,
					text: 'Consolidación Mediciones',
					disabled: true,
					handler: this.onConsolEqMed,
					tooltip: '<b>Consolidación Mediciones</b>',
					scope: this
				}
			]}
			});
			this.tbar.add(this.menuLoc);
			
			this.addButton('btn-incCalen', {
				text: 'Inc./Ret.',
				iconCls: 'blist',
				disabled: true,
				handler: this.onBtnIncluCalGen,
				tooltip: '<b>Considerar o no</b><br/>si la unidad es roja no se la considera en la generacion del calendario'
			});
			
			this.addButton('btn-addEqu', {
				text: 'Agregar Equipo',
				iconCls: 'bgear',
				disabled: true,
				handler: this.onBtnAddEquipo,
				tooltip: '<b>Agregar Equipo</b><br/>Agrega un equipo desde una plantilla en la Localización seleccionada'
			});
			
			this.menuEq = new Ext.Toolbar.SplitButton({
				id: 'btn-ficTec-' + this.idContenedor,
				text: 'Ficha Técnica',
				handler: this.onFichaTecnicaClick,
				disabled: true,
				scope: this,
				menu:{
				items: [{
					id:'btn-mantPredef-' + this.idContenedor,
					text: 'Mantenimientos Predefinidos',
					disabled: true,
					tooltip: '<b>Mantenimientos Predefinidos</b>',
					handler:this.onEqMantClick,
					scope: this
				}, {
					id:'btn-medVar-' + this.idContenedor,
					text: 'Medición de Variables',
					disabled: true,
					tooltip: '<b>Medición de Variables</b>',
					handler:this.onClickMed,
					scope: this
				}, {
					id:'btn-upArch-' + this.idContenedor,
					text: 'Upload Archivos',
					disabled: true,
					handler: this.onClickUp,
					tooltip: '<b>Upload archivos</b>',
					scope: this
				} ,{
					id:'btn-anPorque-' + this.idContenedor,
					text: 'TPM - Análisis Porqué - Porqué',
					disabled: true,
					handler: this.onBtnTPMPorquePorque,
					scope: this
				}, {
					id:'btn-rcmAnalisis-' + this.idContenedor,
					text: 'Análisis RCM',
					disabled: true,
					handler: this.onBtnRCMAnalisis,
					scope: this
				}, {
					id:'btn-rcmPlan-' + this.idContenedor,
					text: 'Planificación RCM',
					disabled: true,
					handler: this.onBtnRCMPlan,
					scope: this
				} 

				 ]
				} 
			});
			this.tbar.add(this.menuEq);

			this.menuOp = new Ext.Toolbar.SplitButton({
				id: 'btn-Calendar-' + this.idContenedor,
				text: 'Planif. Mantenimiento',
				//handler: this.onMedicionesClick,
				iconCls: 'bcalendar',
				disabled: true,
				scope: this,
				 menu:{
				 items: [
				 	 {
					 id:'btn-calGen-' + this.idContenedor,
					 text: 'Generar Calendario',
					 disabled: true,
					 handler: this.onBtnCalGen,
					 tooltip: '<b>Generar Calendario</b><br/>Genera el Caledario para todos los equipos de manera recursiva',
					 scope: this
					 },
				 	 {
					 id:'btn-verCalGen-' + this.idContenedor,
					 text: 'Ver el  Calendario',
					 disabled: true,
					 tooltip: '<b>Ver el calendario</b><br/>Visualiza el Caledario generado de los Equipos seleccionados de forma recursiva',
					 handler:this.onBtnVerCalGen, scope: this
					 },
					 {
                     id:'btn-repCal-' + this.idContenedor,
                     text : 'Reporte Calendario',
                     disabled : true,
                     handler: this.onBtnRepCal,
                     tooltip : '<b>Reporte Calendario</b><br/>Genera el reporte Calendario para todos los equipos de manera recursiva',
                     scope: this
                     }
				 ]
				 }
			});

			this.tbar.add(this.menuOp);
		},
		crearWindowAddEquipo : function() {
			this.formUC = new Ext.form.FormPanel({
				baseCls: 'x-plain-' + this.idContenedor,
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				items: [{
					xtype: 'combo',
					name: 'id_uni_cons',
					fieldLabel: 'Equipo',
					allowBlank: false,
					emptyText: 'Elija un equipo...',
					store: new Ext.data.JsonStore({
						url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
						id: 'id_uni_cons',
						root: 'datos',
						sortInfo: {
							field: 'nombre',
							direction: 'ASC'
						},
						totalProperty: 'total',
						fields: ['id_uni_cons', 'codigo', 'nombre'],
						// turn on remote sorting
						remoteSort: true,
						baseParams: {
							par_filtro: 'tuc.nombre#tuc.codigo',
							tipo: 'tuc'
						}
					}),
					valueField: 'id_uni_cons',
					displayField: 'nombre',
					forceSelection: true,
					typeAhead: false,
					triggerAction: 'all',
					lazyRender: true,
					mode: 'remote',
					pageSize: 20,
					queryDelay: 500,
					width: 250,
					listWidth: '280',
					minChars: 2
				}, {
					xtype: 'textfield',
					name: 'codigo_uni_cons',
					fieldLabel: 'Código',
					allowBlank: false,
				}]
			});

			var cmbUC = this.formUC.getForm().findField('id_uni_cons');
			cmbUC.store.on('exception', this.conexionFailure, this)
			var codigo = this.formUC.getForm().findField('codigo_uni_cons');

			cmbUC.on('select', function(c, a, d) {
				var nodo = this.sm.getSelectedNode();
				codigo.setValue(nodo.parentNode.attributes.codigo + '-' + nodo.attributes.codigo + '-' + a.data.codigo)
			}, this);

			this.wUC = new Ext.Window({
				title: 'Agregar Equipo',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 450,
				height: 250,
				layout: 'fit',
				plain: true,
				bodyStyle: 'padding:5px;',
				buttonAlign: 'center',
				items: this.formUC,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onAddUniCons,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.wUC.hide()
					},
					scope: this
				}]
			});

		},
		crearWindowCalendario: function() {
			this.formUCCL = new Ext.form.FormPanel({
				//baseCls: 'x-plain',
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				autoScroll: true,
				/*layout: {
				 type: 'vbox',
				 align: 'stretch'  // Child items are stretched to full width
				 },*/
				defaults: {
					xtype: 'textfield'
				},

				items: [/*{
				 xtype: 'datefield',
				 name: 'fecha_ini',
				 fieldLabel: 'Inicia',
				 format:'d-m-Y',
				 allowBlank: false,
				 allowBlank: false
				 },*/
				{
					xtype: 'datefield',
					name: 'fecha_fin',
					fieldLabel: 'Termina',
					format: 'd-m-Y',
					allowBlank: false,
					allowBlank: false
				}]
			});

			//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
			var dateFechaFin = this.formUCCL.getForm().findField('fecha_fin');

			this.wUCCL = new Ext.Window({
				title: 'Calendario',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 400,
				height: 350,
				layout: 'fit',
				//plain: true,
				//bodyStyle: 'padding:5px;',
				buttonAlign: 'center',
				items: this.formUCCL,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onCalGen,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.wUCCL.hide()
					},
					scope: this
				}]
			});
		},
		
		crearWindowGrafInd: function(){
			this.formGrafInd = new Ext.form.FormPanel({
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				autoScroll: true,
				defaults: {
					xtype: 'numberfield'
				},
				items: [
				{
					xtype:'combo',
					name:'tipo',
					fieldLabel:'Tipo Indicador',
					mode:'local',
					store: new Ext.data.ArrayStore({
						id:0,
						fields: ['tipo_indicador','desc_tipo_indicador'],
						data: [
							['tipo_mant','Tipos de Mantenimiento'],
							['costos','Costos de Mantenimiento'],
							['ejecucion','Ejecución de Mantenimiento']
						]
					}),
					valueField:'tipo_indicador',
					displayField:'desc_tipo_indicador',
					triggerAction: 'all',
					value:'tipo_mant'
				},
				{
					xtype:'combo',
					name:'mes_ini',
					fieldLabel:'Mes Inicio',
					mode:'local',
					store: new Ext.data.ArrayStore({
						id:0,
						fields: ['mes','desc_mes'],
						data: [
							['1','Enero'],['2','Febrero'],['3','Marzo'],['4','Abril'],['5','Mayo'],['6','Junio'],['7','Julio'],['8','Agosto'],['9','Septiembre'],['10','Octubre'],['11','Noviembre'],['12','Diciembre']
						]
					}),
					valueField:'mes',
					displayField:'desc_mes',
					triggerAction: 'all',
					value:'1',
					allowBlank: false
				},
				{
					xtype:'combo',
					name:'gestion_ini',
					fieldLabel:'Gestión Inicio',
					mode:'local',
					store: new Ext.data.ArrayStore({
						id:0,
						fields: ['mes','desc_mes'],
						data: [
							['2010','2010'],['2011','2011'],['2012','2012'],['2013','2013'],['2014','2014'],['2015','2015'],['2016','2016'],['2017','2017'],['2018','2018'],['2019','2019'],['2020','2020'],['2021','2021'],['2022','2022'],['2023','2023'],['2024','2024'],['2025','2025']
						]
					}),
					valueField:'mes',
					displayField:'desc_mes',
					triggerAction: 'all',
					value:'2013',
					allowBlank: false
				},
				{
					xtype:'combo',
					name:'mes_fin',
					fieldLabel:'Mes Fin',
					mode:'local',
					store: new Ext.data.ArrayStore({
						id:0,
						fields: ['mes','desc_mes'],
						data: [
							['1','Enero'],['2','Febrero'],['3','Marzo'],['4','Abril'],['5','Mayo'],['6','Junio'],['7','Julio'],['8','Agosto'],['9','Septiembre'],['10','Octubre'],['11','Noviembre'],['12','Diciembre']
						]
					}),
					valueField:'mes',
					displayField:'desc_mes',
					triggerAction: 'all',
					value:'1',
					allowBlank: false
				},
				{
					xtype:'combo',
					name:'gestion_fin',
					fieldLabel:'Gestión Fin',
					mode:'local',
					store: new Ext.data.ArrayStore({
						id:0,
						fields: ['mes','desc_mes'],
						data: [
							['2010','2010'],['2011','2011'],['2012','2012'],['2013','2013'],['2014','2014'],['2015','2015'],['2016','2016'],['2017','2017'],['2018','2018'],['2019','2019'],['2020','2020'],['2021','2021'],['2022','2022'],['2023','2023'],['2024','2024'],['2025','2025']
						]
					}),
					valueField:'mes',
					displayField:'desc_mes',
					triggerAction: 'all',
					value:'2013',
					allowBlank: false
				},
				{
					xtype:'textarea',
					name:'observaciones',
					fieldLabel:'Obervaciones',
					width:'100%',
					maxLength:1000	
				}]
			});

			//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
			var dateFechaFin = this.formGrafInd.getForm().findField('fecha_fin');

			this.wGrafInd = new Ext.Window({
				title: 'Gráficos Indicadores',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 400,
				height: 350,
				layout: 'fit',
				buttonAlign: 'center',
				items: this.formGrafInd,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onGrafInd,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.wGrafInd.hide()
					},
					scope: this
				}]
			});
		},

		onBtnRCMAnalisis: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/analisis_mant/AnalisisMant.php', 'AnalisisMant', {
					modal: true,
					width: 900,
					height: 400
				}, data, this.idContenedor, 'AnalisisMant')

			}

		},

		onBtnRCMPlan: function() {
			var rec = this.sm.getSelectedNode();
			var data = rec.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/plan_mant/PlanMant.php', 'Plan de Mantenimiento', {
					modal: true,
					width: 900,
					height: 600
				}, data, this.idContenedor, 'PlanMant')
			}

		},

		onClickMed: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_medicion/EquipoMedicionDinamico.php', 'Mediciones:' + node.text, {
					modal: true,
					width: 900,
					height: 400
				}, data, this.idContenedor, 'EquipoMedicionDinamico')

			}
		},

		onClickUp: function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data) {
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_archivo/UniConsArchivo.php', 'Upload de archivos', {
					modal: true,
					width: 900,
					height: 500
				}, data, this.idContenedor, 'UniConsArchivo');
			}

		},
		south:{
			  url:'../../../sis_mantenimiento/vista/uni_cons/UniConsGral.php',
			  title:'Equipos', 
			  height:'50%',	//altura de la ventana hijo
			  //width:'50%',		//ancho de la ventana hjo
			  cls:'UniConsGral'
		},
		crearWindowRepFichaTecVar: function() {
			this.formFTV = new Ext.form.FormPanel({
				//baseCls: 'x-plain',
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				autoScroll: true,
				defaults: {
					xtype: 'textfield'
				},

				items: [/*{
				 xtype: 'datefield',
				 name: 'fecha_ini',
				 fieldLabel: 'Inicia',
				 format:'d-m-Y',
				 allowBlank: false,
				 allowBlank: false
				 },*/
				{
					xtype: 'combo',
					name: 'id_tipo_equipo',
					fieldLabel: 'Tipo de Equipo',
					allowBlank: false,
   				    emptyText:'Seleccione un Tipo de Equipo...',
   				    store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoEquipo/listarTipoEquipo',
					id: 'id_tipo_equipo',
					root: 'datos',
					sortInfo:{
						field: 'codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_equipo','codigo','nombre','descripcion'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'codigo#nombre#descripcion'}
					}),
					hiddenName: 'id_tipo_equipo',
					valueField: 'id_tipo_equipo',
	       			displayField: 'nombre',
	       			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:200,
       				anchor:'100%',
       				minChars:2,
       				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>{codigo}</p> </div></tpl>'
				}
				
				
				]
			});

			//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
			var intIdTipoEquipo = this.formFTV.getForm().findField('id_tipo_equipo');

			this.wFTV = new Ext.Window({
				title: 'Parámetro de generación del reporte',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 400,
				height: 150,
				layout: 'fit',
				buttonAlign: 'center',
				items: this.formFTV,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Generar',
					handler: this.onRepFichaTecVar,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.wFTV.hide()
					},
					scope: this
				}]
			});

		},
		onRepFichaTecVar: function() {
			var nodo = this.sm.getSelectedNode();
			var data = nodo.attributes;
			if (this.formFTV.getForm().isValid()) {
				Phx.CP.loadingShow();

				var tiponodo = nodo.attributes.tipo_nodo;
				//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
				var intIdTipoEquipo = this.formFTV.getForm().findField('id_tipo_equipo');
				if (tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo == 'rama') {
					var id_nodo = nodo.attributes.id_uni_cons;
					data.id_uni_cons = id_nodo;
					data.id_localizacion='-1';
				} else {
					id_nodo = nodo.attributes.id_localizacion;
					data.id_localizacion = id_nodo;
					data.id_uni_cons='-1';
				}
				//data.id_localizacion = id_nodo;
				data.id_tipo_equipo = intIdTipoEquipo.getValue();
				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_det/EquipoFichaTecnicaVariables.php', 'Ficha Técnica - Variables: ', {
					width : 800,
					height : 400
				}, data, this.idContenedor, 'EquipoFichaTecnicaVariables')
				
				this.wFTV.hide();
		}
	},
	onBtnFichaTecVar: function() {
			var nodo = this.sm.getSelectedNode();
			if (nodo) {
				this.wFTV.show()
			}
	},
	getColumnasNodo: function(){
		var nodo = this.sm.getSelectedNode();
		var data = nodo.attributes;
		
		var aux=[{ 
		   	    label:'Código',
				name:'codigo',
				width:'100',
				type:'string',
				gdisplayField:'Código',
				value:data.codigo
			},{
				label:'Nombre',
				name:'nombre',
				width:'200',
				type:'string',
				gdisplayField:'Código',
				value:data.nombre
			}]
		var ff= Phx.vista.Localizacion.superclass.getColumnasNodo.call(this,aux);
		//console.log(ff);
		return aux;
	} /*,
	
	Grupos: [
            {
                layout: 'column',
                border: false,
                defaults: {
                   border: false
                },            
                items: [{
					        bodyStyle: 'padding-right:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Datos principales',
					            autoHeight: true,
					            items: [],
						        id_grupo:1
					        }]
					    },
					    {
					        bodyStyle: 'padding-right:5px;',
					        items: [{
					            xtype: 'fieldset',
					            title: 'Tree',
					            autoHeight: true,
					            items: [
					            {
					                animate:true,
					                xtype: 'treepanel',
					                autoScroll:true,
					                loader: new Ext.tree.TreeLoader({dataUrl:'get-nodes.php'}),
					                enableDD:false,
					                containerScroll: true,
					                border: false,
					                width: 250,
					                height: 300,
					                root: new Ext.tree.AsyncTreeNode({
						                text: 'Ext JS', 
						                draggable:false
						            })
					            }
										            
					            ]
					        }]
					    }]
            }
        ]*/
})
</script>

