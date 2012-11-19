<?php
/**
 * @package pxP
 * @file    Transferencia.php
 * @author  Gonzalo Sarmiento
 * @date    27-09-2012
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.TransferenciaAbs=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.TransferenciaAbs.superclass.constructor.call(this,config);
        this.init();
        this.load({params:{start:0, limit:50, codigo:'TRANSFERENCIA'}})
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_movimiento'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'codigo'
            },
            type:'Field',
            form:true,
            valorInicial: 'TRA'     
        },
        {
            config:{
                name:'id_almacen',
                fieldLabel:'Almacen origen',
                allowBlank:false,
                emptyText:'Almacen...',
                store: new Ext.data.JsonStore({

                    url: '../../sis_almacenes/control/Almacen/listarAlmacen',
                    id: 'id_almacen',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_almacen','nombre'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre'}
                }),
                valueField: 'id_almacen',
                displayField: 'nombre',
                //gdisplayField:'nombre_origen',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
                tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p> </div></tpl>',
                hiddenName: 'id_almacen',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:260,
                gwidth:100,
                
                renderer:function (value, p, record){return String.format('{0}', record.data['nombre_origen']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                        pfiltro:'nombre',
                        type:'string'
                    },
           
            grid:true,
            form:true
        },
        {
          config:{
                name:'id_funcionario',
                fieldLabel:'Funcionario',
                allowBlank:false,
                emptyText:'Funcionario...',
                store: new Ext.data.JsonStore({

                    url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
                    id: 'id_funcionario',
                    root: 'datos',
                    sortInfo:{
                        field: 'desc_person',
                        direction: 'ASC'
                    },
                    fields: ['id_funcionario','desc_person'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'desc_person'}
                }),
                valueField: 'id_funcionario',
                displayField: 'desc_person',
                gdisplayField: 'desc_person',
                hiddenName: 'id_funcionario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                enableMultiSelect:true,
            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}

            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   pfiltro:'desc_funcionario1',
                        type:'string'
                    },
            grid:true,
            form:true
        },
        {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name:'id_proveedor'
            },
            type:'NumberField',
            form:true
        },
        {
            config:{
                name:'id_almacen_dest',
                fieldLabel:'Almacen destino',
                allowBlank:false,
                emptyText:'Almacen...',
                store: new Ext.data.JsonStore({

                    url: '../../sis_almacenes/control/Almacen/listarAlmacen',
                    id: 'id_almacen',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_almacen','nombre'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre'}
                }),
                valueField: 'id_almacen',
                displayField: 'nombre',
                //gdisplayField:'nombre_origen',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
                tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p> </div></tpl>',
                hiddenName: 'id_almacen_dest',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:260,
                
                renderer:function (value, p, record){return String.format('{0}', record.data['nombre_destino']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                        pfiltro:'nombre',
                        type:'string'
                    },
           
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha_mov',
                fieldLabel: 'Fecha de movimiento',
                allowBlank: false,
                anchor: '80%',
                //gwidth: 120,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'numero_mov',
                fieldLabel: 'Nº de movimiento',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:5
            },
            type:'TextField',
            filters:{type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'descripcion',
                fieldLabel: 'Descripcion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 300,
                maxLength:300
            },
            type:'TextField',
            filters:{type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'observaciones',
                fieldLabel: 'Observaciones',
                allowBlank: true,
                anchor: '80%',
                gwidth: 300,
                maxLength:300
            },
            type:'TextField',
            filters:{type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_usuario_reg',
                fieldLabel: 'Id usuario reg.',
                anchor: '80%',
                gwidth: 90,
                maxLength: 5
            },
            type:'NumberField',
            id_grupo:1,
            grid: true,
            form: false
        },
        {
            config:{
                name: 'fecha_reg',
                fieldLabel: 'Fecha de registro',
                anchor: '80%',
                //gwidth: 110,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name:'id_usuario_mod',
                fieldLabel: 'Id usuario modif.',
                anchor: '80%',
                gwidth: 100,
                maxLength: 5
            },
            type:'NumberField',
            id_grupo:1,
            grid: true,
            form: false
        },
        {
            config:{
                name: 'fecha_mod',
                fieldLabel: 'Fecha de modificacion',
                anchor: '80%',
                //gwidth: 110,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name:'estado_mov',
                fieldLabel:'Estado transferencia',
                anchor:'80%',
                gwidth:120              
            },
            type:'TextField',
            grid:true,
            form:false
        }       
    ],
    ActSave:'../../sis_almacenes/control/Movimiento/insertarMovimiento',
    ActDel:'../../sis_almacenes/control/Movimiento/eliminarMovimiento',
    ActList:'../../sis_almacenes/control/Movimiento/listarMovimiento',
    id_store:'id_movimiento',
    fields: [
        {name:'id_movimiento'},
        {name:'id_almacen',type:'integer'},
        {name: 'nombre_origen',type:'string'},      
        {name: 'id_funcionario',type:'integer'},
        {name: 'desc_funcionario1',type:'string'},
        {name:'id_almacen_dest',type:'integer'},
        {name: 'nombre_destino',type:'string'},
        {name:'fecha_mov',type:'timestamp'},
        {name:'numero_mov', type: 'string'},
        {name:'descripcion', type: 'string'},
        {name:'observaciones', type: 'string'},             
        {name:'id_usuario_reg',type: 'integer'},
        {name:'fecha_reg',type:'timestamp'},
        {name:'id_usuario_mod',type: 'integer'},
        {name:'fecha_mod',type:'timestamp'},
        {name:'estado_mov',type:'string'}   
    ],
    sortInfo:{
        field: 'id_movimiento',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    east:{
          url:'../../../sis_almacenes/vista/detalleMateriales/DetalleMateriales.php',
          title:'Detalle de materiales', 
          width:400,
          cls:'DetalleMateriales'
         }
    }
)
</script>       
        