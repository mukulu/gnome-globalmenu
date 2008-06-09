#include <gtk/gtk.h>
#include <glade/glade.h>
void show_arrow_toggled(GtkWidget * toggle, GtkMenuBar * menubar){
	g_object_set(menubar, "show-arrow", 
			gtk_toggle_button_get_active(toggle), NULL);
}
void is_global_toggled(GtkWidget * toggle, GtkMenuBar * menubar){
	g_object_set(menubar, "is-global-menu", 
			gtk_toggle_button_get_active(toggle), NULL);
}
int main (int argc, char **argv){ 
	    GladeXML *xml;
	GtkWidget * window;
	GtkBox * box;
	GtkBox * hbox;
	GtkWidget * is_global;
	GtkWidget * show_arrow;
	GtkMenuBar * menubar;

	gtk_init(&argc, &argv);
	xml = glade_xml_new("testintro.glade", NULL, NULL);

	/* get a widget (useful if you want to change something) */
	menubar = glade_xml_get_widget(xml, "menubar1");
	/* connect signal handlers */
//	glade_xml_signal_autoconnect(xml);


	window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	box = gtk_vbox_new(0, FALSE);
	hbox = gtk_hbox_new(0, FALSE);
	gtk_container_add(window, box);
	gtk_container_add(box, hbox);
	gtk_container_add(box, menubar);
	show_arrow = gtk_check_button_new_with_label("show_arrow");
	is_global = gtk_check_button_new_with_label("is_global");
	gtk_container_add(hbox, show_arrow);
	gtk_container_add(hbox, is_global);
	g_signal_connect(show_arrow, "toggled", show_arrow_toggled, menubar);
	g_signal_connect(is_global, "toggled", is_global_toggled, menubar);
	gtk_widget_show_all(window);
	gtk_main();
	return 0;
}