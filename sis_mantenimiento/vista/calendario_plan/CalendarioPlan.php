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
Phx.vista.CalendarioPlan = Ext.extend(Phx.baseInterfaz,{
	
	constructor:function(config){
		
		Phx.vista.CalendarioPlan.superclass.constructor.call(this,config);
	
		
		console.log('id contenedor',this.idTmp)
		//this.definirComponentes();
    	//definir formulario tipo venatana
    	//this.definirFormularioVentana();
    	
    	//inicia barra de menu
    	
   
    	this.idTmp = Ext.id();
    	
    	var b=[];
    	
    	     b.push({
                            xtype: 'datefield',
                            id:this.idTmp+'-app-nav-picker',
                         //   cls: 'ext-cal-nav-picker',
                            listeners: {
                                'select': {
                                    fn: function(dp, dt){
                                        Phx.vista.CalendarioPlan.calendarPanel.setStartDate(dt);
                                    },
                                    scope: this
                                }
                            }
                        })
    	
		this.defineMenu(b);
		
	
	

            
            Ext.BLANK_IMAGE_URL = 'http://extjs.cachefly.net/ext-3.1.0/resources/images/default/s.gif';
            
            
			var calendarList = {
				    "calendars":[{
				        "id":1,
				        "title":"Home"
				    },{
				        "id":2,
				        "title":"Work"
				    },{
				        "id":3,
				        "title":"School"
				    }]
				};
				
				
			var today = new Date().clearTime();
			var eventList = {
			    "evts": [{
			        "id": 1001,
			        "cid": 1,
			        "title": "Vacation",
			        "start": today.add(Date.DAY, -20).add(Date.HOUR, 10),
			        "end": today.add(Date.DAY, -10).add(Date.HOUR, 15),
			        "ad": false,
			        "notes": "Have fun"
			    },
			    {
			        "id": 1002,
			        "cid": 2,
			        "title": "Lunch with Matt",
			        "start": today.add(Date.HOUR, 11).add(Date.MINUTE, 30),
			        "end": today.add(Date.HOUR, 13),
			        "ad": false,
			        "loc": "Chuy's!",
			        "url": "http://chuys.com",
			        "notes": "Order the queso",
			        "rem": "15"
			    },
			    {
			        "id": 1003,
			        "cid": 3,
			        "title": "Project due",
			        "start": today.add(Date.HOUR, 15),
			        "end": today.add(Date.HOUR, 15),
			        "ad": false
			    },
			    {
			        "id": 1004,
			        "cid": 1,
			        "title": "Sarah's birthday",
			        "start": today,
			        "end": today,
			        "notes": "Need to get a gift",
			        "ad": true
			    },
			    {
			        "id": 1005,
			        "cid": 2,
			        "title": "A long one...",
			        "start": today.add(Date.DAY, -12),
			        "end": today.add(Date.DAY, 10).add(Date.SECOND, -1),
			        "ad": true
			    },
			    {
			        "id": 1006,
			        "cid": 3,
			        "title": "School holiday",
			        "start": today.add(Date.DAY, 5),
			        "end": today.add(Date.DAY, 7).add(Date.SECOND, -1),
			        "ad": true,
			        "rem": "2880"
			    },
			    {
			        "id": 1007,
			        "cid": 1,
			        "title": "Haircut",
			        "start": today.add(Date.HOUR, 9),
			        "end": today.add(Date.HOUR, 9).add(Date.MINUTE, 30),
			        "ad": false,
			        "notes": "Get cash on the way"
			    },
			    {
			        "id": 1008,
			        "cid": 3,
			        "title": "An old event",
			        "start": today.add(Date.DAY, -30),
			        "end": today.add(Date.DAY, -28),
			        "ad": true,
			        "notes": "Get cash on the way"
			    },
			    {
			        "id": 1009,
			        "cid": 2,
			        "title": "Board meeting",
			        "start": today.add(Date.DAY, -2).add(Date.HOUR, 13),
			        "end": today.add(Date.DAY, -2).add(Date.HOUR, 18),
			        "ad": false,
			        "loc": "ABC Inc.",
			        "rem": "60"
			    },
			    {
			        "id": 1010,
			        "cid": 3,
			        "title": "Jenny's final exams",
			        "start": today.add(Date.DAY, -2),
			        "end": today.add(Date.DAY, 3).add(Date.SECOND, -1),
			        "ad": true
			    },
			    {
			        "id": 10011,
			        "cid": 1,
			        "title": "Movie night",
			        "start": today.add(Date.DAY, 2).add(Date.HOUR, 19),
			        "end": today.add(Date.DAY, 2).add(Date.HOUR, 23),
			        "ad": false,
			        "notes": "Don't forget the tickets!",
			        "rem": "60"
			    }]
			};
				

            

            // This is an example calendar store that enables the events to have
            // different colors based on CalendarId. This is not a fully-implmented
            // multi-calendar implementation, which is beyond the scope of this sample app
            this.calendarStore = new Ext.data.JsonStore({
                storeId: 'calendarStore',
                root: 'calendars',
                idProperty: 'id',
                data: calendarList, // defined in calendar-list.js
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: [
                    {name:'CalendarId', mapping: 'id', type: 'int'},
                    {name:'Title', mapping: 'title', type: 'string'}
                ],
                sortInfo: {
                    field: 'CalendarId',
                    direction: 'ASC'
                }
            });

            // A sample event store that loads static JSON from a local file. Obviously a real
            // implementation would likely be loading remote data via an HttpProxy, but the
            // underlying store functionality is the same.  Note that if you would like to 
            // provide custom data mappings for events, see EventRecord.js.
		    this.eventStore = new Ext.data.JsonStore({
		       // id: 'eventStore',
		        root: 'evts',
		        data: eventList, // defined in event-list.js
				proxy: new Ext.data.MemoryProxy(),
		        fields: Ext.calendar.EventRecord.prototype.fields.getRange(),
		        sortInfo: {
		            field: 'StartDate',
		            direction: 'ASC'
		        }
		    });
            
            // This is the app UI layout code.  All of the calendar views are subcomponents of
            // CalendarPanel, but the app title bar and sidebar/navigation calendar are separate
            // pieces that are composed in app-specific layout code since they could be ommitted
            // or placed elsewhere within the application.
            
            alert('0000')
           
           
           /*
            
            *  {
                   
                
                
               
                      
                        region:'west',
                        width: 176,
                        border: false,
                        items: [{
                            xtype: 'datepicker',
                            id: 'app-nav-picker',
                            cls: 'ext-cal-nav-picker',
                            listeners: {
                                'select': {
                                    fn: function(dp, dt){
                                        Phx.vista.CalendarioPlan.calendarPanel.setStartDate(dt);
                                    },
                                    scope: this
                                }
                            }
                        }]
                    }
            * */
           
           
           
        
      
          
          
          
          // this.VP =  new Ext.calendar.CalendarPanel();
            
            alert('this.idTmp')
            alert(this.idTmp)
            
            
            
        this.vpp=   new Ext.Container({
                layout: 'border', 
                 region: 'center',
                 tbar:this.tbar,
               
                items: [{
                    id:this.idTmp+'-app-header',
                    region: 'north',
                    height: 45,
                    layout: 'fit',
                    border: false,
                    items:[this.tbar]
                   
                }, /*{
                       
                        region: 'west',
                        width: 176,
                        border: false,
                        items: [{
                            xtype: 'datepicker',
                            id:this.idTmp+'-app-nav-picker',
                         //   cls: 'ext-cal-nav-picker',
                            listeners: {
                                'select': {
                                    fn: function(dp, dt){
                                        Phx.vista.CalendarioPlan.calendarPanel.setStartDate(dt);
                                    },
                                    scope: this
                                }
                            }
                        }]
                    },*/
                    
                   {
                    id: this.idTmp+'-app-center',
                    title: '...', // will be updated to view date range
                    region: 'center',
                    layout: 'border',
                    items: [{ 
                    
                   
                    	xtype: 'calendarpanel',
           
           	 
          eventStore: this.eventStore,
         
                        calendarStore: this.calendarStore,
                       // border: true,
                       id:this.idTmp+'-app-calendar',
                        region: 'center',
                        	margins:'3 3 3 0',
                        // layout: 'fit', 
                         // autoDestroy: true,
                        activeItem: 2, // month view
                        
                        // CalendarPanel supports view-specific configs that are passed through to the 
                        // underlying views to make configuration possible without explicitly having to 
                        // create those views at this level:
                        monthViewCfg: {
                            showHeader: true,
                            showWeekLinks: true,
                            showWeekNumbers: true
                        },
                        
                        // Some optional CalendarPanel configs to experiment with:
                        //showDayView: false,
                        //showWeekView: false,
                        //showMonthView: false,
                        //showNavBar: false,
                        //showTodayText: false,
                        //showTime: false,
                        //title: 'My Calendar', // the header of the calendar, could be a subtitle for the app
                        
                        // Once this component inits it will set a reference to itself as an application
                        // member property for easy reference in other functions within App.
                        initComponent: function() {
                            Phx.vista.CalendarioPlan.calendarPanel = this;
                            this.constructor.prototype.initComponent.apply(this, arguments);
                        },
                        
                        listeners: {
                            'eventclick': {
                                fn: function(vw, rec, el){
                                    this.showEditWindow(rec, el);
                                    this.clearMsg();
                                },
                                scope: this
                            },
                            'eventover': function(vw, rec, el){
                                //console.log('Entered evt rec='+rec.data.Title+', view='+ vw.id +', el='+el.id);
                            },
                            'eventout': function(vw, rec, el){
                                //console.log('Leaving evt rec='+rec.data.Title+', view='+ vw.id +', el='+el.id);
                            },
                            'eventadd': {
                                fn: function(cp, rec){
                                    this.showMsg('Event '+ rec.data.Title +' was added');
                                },
                                scope: this
                            },
                            'eventupdate': {
                                fn: function(cp, rec){
                                    this.showMsg('Event '+ rec.data.Title +' was updated');
                                },
                                scope: this
                            },
                            'eventdelete': {
                                fn: function(cp, rec){
                                    this.showMsg('Event '+ rec.data.Title +' was deleted');
                                },
                                scope: this
                            },
                            'eventcancel': {
                                fn: function(cp, rec){
                                    // edit canceled
                                },
                                scope: this
                            },
                            'viewchange': {
                                fn: function(p, vw, dateInfo){
                                	
                                	
                                	
                                	console.log('viewchange')
                                	
                                	
                                
                                    if(this.editWin){
                                        this.editWin.hide();
                                    };
                                    
                                    
                                    if(dateInfo !== null){
                                        // will be null when switching to the event edit form so ignore
                                        Ext.getCmp(this.idTmp+'-app-nav-picker').setValue(dateInfo.activeDate);
                                        this.updateTitle(dateInfo.viewStart, dateInfo.viewEnd);
                                    }                                },
                                scope: this
                            },
                            'dayclick': {
                                fn: function(vw, dt, ad, el){
                                    this.showEditWindow({
                                        StartDate: dt,
                                        IsAllDay: ad
                                    }, el);
                                    this.clearMsg();
                                },
                                scope: this
                            },
                            'rangeselect': {
                                fn: function(win, dates, onComplete){
                                    this.showEditWindow(dates);
                                    
                                    
                                	console.log('rangeselect')
                                	
                                    this.editWin.on('hide', onComplete, this, {single:true});
                                    
                                    
                                    
                                    this.clearMsg();
                                },
                                scope: this
                            },
                            'eventmove': {
                                fn: function(vw, rec){
                                    rec.commit();
                                    var time = rec.data.IsAllDay ? '' : ' \\a\\t g:i a';
                                    this.showMsg('Event '+ rec.data.Title +' was moved to '+rec.data.StartDate.format('F jS'+time));
                                },
                                scope: this
                            },
                            'eventresize': {
                                fn: function(vw, rec){
                                    rec.commit();
                                    this.showMsg('Event '+ rec.data.Title +' was updated');
                                },
                                scope: this
                            },
                            'eventdelete': {
                                fn: function(win, rec){
                                    this.eventStore.remove(rec);
                                    this.showMsg('Event '+ rec.data.Title +' was deleted');
                                },
                                scope: this
                            },
                            'initdrag': {
                                fn: function(vw){
                                	
                                	console.log('initdrag')
                                	
                                	
                                    if(this.editWin && this.editWin.isVisible()){
                                        this.editWin.hide();
                                    }
                                },
                                scope: this
                            }
                        }
                        
                   }]
               
                }]
            
            
            
            })
                    
          
            
            
            
		this.regiones= new Array();
		//this.regiones.push( this.tbar)
		//ubica el grid en la region central
		
	
	
	
		this.regiones.push(this.vpp);
		
		
		
		
		/*arma los panles de ventanas hijo*/
		this.definirRegiones()
		
            
      
        
            this.panel.doLayout(true,true)
        
        alert('2')
        //this.panel.add(this.treePanel);
        //this.panel.on('beforedestroy', this.onDestroy, this);
        //this.panel.on('beforehide', this.onHide, this);
        //this.panel.on('beforeshow', this.onShow, this);
            
            
         
          
            
            
          //this.panel.doLayout(true,true)
            
             alert('3')  
            
            
        },
       
		showEditWindow : function(rec, animateTarget){
	       
	       
	        if(!this.editWin){
	        	
	        	console.log('crea ventana',this.idTmp)
	        	
	        //CREACION DE LA VENTANA DE EDICION
	        	
	             this.editWin = new Ext.calendar.EventEditWindow({
                    calendarStore: this.calendarStore,
					listeners: {
						'eventadd': {
							fn: function(win, rec){
								win.hide();
								rec.data.IsNew = false;
								this.eventStore.add(rec);
                                this.showMsg('Event '+ rec.data.Title +' was added');
							},
							scope: this
						},
						'eventupdate': {
							fn: function(win, rec){
								win.hide();
								rec.commit();
                                this.showMsg('Event '+ rec.data.Title +' was updated');
							},
							scope: this
						},
						'eventdelete': {
							fn: function(win, rec){
								this.eventStore.remove(rec);
								win.hide();
                                this.showMsg('Event '+ rec.data.Title +' was deleted');
							},
							scope: this
						},
                        'editdetails': {
                            fn: function(win, rec){
                                win.hide();
                                Phx.vista.CalendarioPlan.calendarPanel.showEditForm(rec);
                            }
                        }
					}
                });
	        }
	        this.editWin.show(rec, animateTarget);
		},
        
        // The CalendarPanel itself supports the standard Panel title config, but that title
        // only spans the calendar views.  For a title that spans the entire width of the app
        // we added a title to the layout's outer center region that is app-specific. This code
        // updates that outer title based on the currently-selected view range anytime the view changes.
        updateTitle: function(startDt, endDt){
        	
            var p = Ext.getCmp(this.idTmp+'-app-center');
            
            if(startDt.clearTime().getTime() == endDt.clearTime().getTime()){
                p.setTitle(startDt.format('F j, Y'));
            }
            else if(startDt.getFullYear() == endDt.getFullYear()){
                if(startDt.getMonth() == endDt.getMonth()){
                    p.setTitle(startDt.format('F j') + ' - ' + endDt.format('j, Y'));
                }
                else{
                    p.setTitle(startDt.format('F j') + ' - ' + endDt.format('F j, Y'));
                }
            }
            else{
                p.setTitle(startDt.format('F j, Y') + ' - ' + endDt.format('F j, Y'));
            }
            
            
        },
        
        // This is an application-specific way to communicate CalendarPanel event messages back to the user.
        // This could be replaced with a function to do "toast" style messages, growl messages, etc. This will
        // vary based on application requirements, which is why it's not baked into the CalendarPanel.
        showMsg: function(msg){
           alert(msg)
            //Ext.fly('app-msg').update(msg).removeClass('x-hidden');
            
            
        },
        
        clearMsg: function(){
            //Ext.fly('app-msg').update('').addClass('x-hidden');
            
            
        },
        
        onDestroy:function(config){
        	console.log(config)
        	
        	//this.editWin.
        	
		   Phx.vista.CalendarioPlan.superclass.onDestroy.call(this,config);
		   
		   delete Ext.calendar._statusProxyInstance;
	
        	
        	
        }
	
	
	
})
	
	

</script>
		