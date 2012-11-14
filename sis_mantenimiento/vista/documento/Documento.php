<?php
/**
*@package pXP
*@file gen-Documento.php
*@author  (admin)
*@date 28-08-2012 22:24:50
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Documento=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.Documento.superclass.constructor.call(this,config);
        
        this.init();
        this.load({params:{start:0, limit:50}});
        
        this.addButton('btnUpload', {
                text : 'Archivos',
                iconCls : 'bupload1',
                disabled : true,
                handler : SubirArchivo,
                tooltip : '<b>Archivos</b><br/>Archivos subidos'
        });

        function SubirArchivo()
        {                   
            var rec=this.sm.getSelected();
                        
            Phx.CP.loadWindows('../../../sis_mantenimiento/vista/documento/SubirDocumento.php',
            'Subir documento',
            {
                modal:true,
                width:450,
                height:150
            },rec.data,this.idContenedor,'SubirDocumento')
        }  
        
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_documento'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                name: 'codigo',
                fieldLabel: 'Código',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:150
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre',
                allowBlank: true,
                anchor: '100%',
                gwidth: 130,
                maxLength:150
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.nombre',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                fieldLabel: "Link",
                gwidth: 130,
                inputType:'file',
                name: 'archivo',
                buttonText: '',   
                maxLength:150,
                anchor:'100%',
                renderer:function (value, p, record){                      
                            if(record.data['extension'].length!=0)
                            return  String.format('{0}',"<div style='text-align:center'><a href = '../../../sis_mantenimiento/control/documentos/"+ record.data['archivo']+"' align='center' width='70' height='70'>documento</a></div>");
                        },  
                buttonCfg: {
                    iconCls: 'upload-icon'
                }
            },
            type:'Field',
            sortable:false,
            //filters:{type:'string'},
            id_grupo:0,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'resumen',
                fieldLabel: 'Resumen',
                allowBlank: true,
                anchor: '100%',
                gwidth: 300,
                maxLength:1000
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.resumen',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre_archivo',
                fieldLabel: 'Nombre Archivo',
                allowBlank: true,
                anchor: '100%',
                gwidth: 120,
                maxLength:100
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.nombre_archivo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },        
        {
            config:{
                name: 'extension',
                fieldLabel: 'Extensión',
                allowBlank: true,
                anchor: '100%',
                gwidth: 70,
                maxLength:10
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.extension',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'palabras_clave',
                fieldLabel: 'Palabras Clave',
                allowBlank: true,
                anchor: '100%',
                gwidth: 200,
                maxLength:3000
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.palabras_clave',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'tipo',
                fieldLabel: 'Tipo',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:4
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.tipo',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },      
        {
            config:{
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'TextField',
            filters:{pfiltro:'gedocu.estado_reg',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },      
        {
            config:{
                name: 'fecha_reg',
                fieldLabel: 'Fecha creación',
                allowBlank: true,
                anchor: '80%',
                //gwidth: 109,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
                format:'Y-m-d'
            },
            type:'DateField',
            filters:{pfiltro:'gedocu.fecha_reg',type:'date'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'usr_reg',
                fieldLabel: 'Creado por',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'usu1.cuenta',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'fecha_mod',
                fieldLabel: 'Fecha Modif.',
                allowBlank: true,
                anchor: '80%',
                //gwidth: 109,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
                format:'Y-m-d'
            },
            type:'DateField',
            filters:{pfiltro:'gedocu.fecha_mod',type:'date'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'usr_mod',
                fieldLabel: 'Modificado por',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'usu2.cuenta',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        }
    ],
    title:'Documentos',
    ActSave:'../../sis_mantenimiento/control/Documento/insertarDocumento',
    ActDel:'../../sis_mantenimiento/control/Documento/eliminarDocumento',
    ActList:'../../sis_mantenimiento/control/Documento/listarDocumento',
    id_store:'id_documento',
    fields: [
        {name:'id_documento', type: 'numeric'},
        {name:'nombre', type: 'string'},
        {name:'codigo', type: 'string'},
        {name:'resumen', type: 'string'},
        {name:'nombre_archivo', type: 'string'},
        {name:'extension', type: 'string'},
        {name:'palabras_clave', type: 'string'},
        {name:'tipo',type:'string'},
        {name:'archivo'},
        {name:'estado_reg', type: 'string'},
        {name:'id_documento_padre', type: 'numeric'},
        {name:'fecha_reg', type: 'timestamp'},
        {name:'id_usuario_reg', type: 'numeric'},
        {name:'fecha_mod', type: 'timestamp'},
        {name:'id_usuario_mod', type: 'numeric'},
        {name:'usr_reg', type: 'string'},
        {name:'usr_mod', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_documento',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    
    preparaMenu:function(tb){
        // llamada funcion clase padre
        Phx.vista.Documento.superclass.preparaMenu.call(this,tb)
        this.getBoton('btnUpload').enable();
    },
    
    liberaMenu:function(tb){
        // llamada funcion clase padre
        Phx.vista.Documento.superclass.liberaMenu.call(this,tb)
        this.getBoton('btnUpload').disable();     
    },
    south:{
          url:'../../../sis_mantenimiento/vista/documento/ListarVersiones.php',
          title:'Versiones del archivo', 
          width:400,
          height:300,
          cls:'ListarVersiones'
    }
}
)
</script>