<?php
/**
*@package pXP
*@file GenerarReporteCalendario.php
*@author  Gonzalo Sarmiento Sejas
*@date    02-01-2013
*@description Archivo con la interfaz para generación de reporte
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.GenerarReporteCalendario=Ext.extend(Phx.frmInterfaz,{
    Atributos:[                  
        {
        config:{
            id: 'fecha_ini',
            name:'fecha_ini',
            fieldLabel:'Fecha Inicio',
            allowBlank:false,
            vtype: 'daterange',
            endDateField:'fecha_fin',
            format:'d/m/Y'           
        },
        type:'DateField'
        },
        {
            config:{
                id: 'fecha_fin',
                name:'fecha_fin',
                fieldLabel:'Fecha Fin',
                allowBlank:false,
                vtype: 'daterange',
                startDateField:'fecha_ini',
                format:'d-m-Y'
            },
            type:'DateField'
        },
        {
          config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'tipo_nodo'
            },
            type:'Field',
            form:true 
        },
        {
          config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_localizacion'
            },
            type:'Field',
            form:true 
        },
        {
          config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_uni_cons'
            },
            type:'Field',
            form:true 
        },
        {
          config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'localizacion'
            },
            type:'Field',
            form:true 
        },        
    ],
    title:'Generar Reporte',
    ActSave:'../../sis_mantenimiento/control/CalendarioPlanificado/listarCalendarioPlanificadoRep',
    topBar:true,
    botones:false,
    labelSubmit:'Imprimir',
    tooltipSubmit:'<b>Generar Calendario Planificado</b>',    
    
    constructor: function(config){
        Phx.vista.GenerarReporteCalendario.superclass.constructor.call(this,config);
        this.init();           
        var id_localizacion=(this.tipo_nodo=='uni_cons'||this.tipo_nodo=='rama')?undefined:this.id_localizacion;
        this.getComponente('id_localizacion').setValue(id_localizacion);
        this.getComponente('tipo_nodo').setValue(this.tipo_nodo);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);
        this.getComponente('localizacion').setValue(this.nombre);      
    },
    
    loadValoresIniciales:function(){       
        this.getComponente('id_localizacion').setValue(this.id_localizacion);
        this.getComponente('tipo_nodo').setValue(this.tipo_nodo);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);
        this.getComponente('localizacion').setValue(this.nombre);
    },
    tipo:'reporte',
    clsSubmit:'bprint'
    
})
</script>