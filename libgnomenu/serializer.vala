using Gtk;

namespace Gnomenu {
	public class Serializer {
		public static string to_string(MenuShell shell, bool pretty_print = false) {
			var s = new Serializer();
			s.pretty_print = pretty_print;
			s.visit(shell);
			return s.sb.str;
		}

		Serializer () {
			this.sb = new StringBuilder("");
		}	

		private void visit(GLib.Object node) {
			if(node is MenuShell) {
				visit_shell(node as MenuShell);
			}
			if(node is MenuItem) {
				visit_item(node as MenuItem);
			}
		}
		private void visit_shell(MenuShell shell) {
			int i;
			if(((MenuShellHelper)shell).length() > 0) {
				indent();
				sb.append_printf("<menu>");
				newline();
				level++;
				for(i = 0; i< ((MenuShellHelper)shell).length(); i++) {
					visit(((MenuShellHelper)shell).get(i));
				}
				level--;
				indent();
				sb.append_printf("</menu>");
				newline();
			} else {
				indent();
				sb.append_printf("<menu/>");
				newline();
			}
		}
		private void visit_item(MenuItem item) {
			if(item.submenu != null) {
				indent();
				sb.append_printf("<item");
				visit_item_attributes(item);
				sb.append_c('>');
				newline();
				level++;
				visit_shell(item.submenu);
				level--;
				indent();
				sb.append_printf("</item>");
				newline();
			} else {
				indent();
				sb.append_printf("<item");
				visit_item_attributes(item);
				sb.append("/>");
				newline();
			}
		}
		private void visit_item_attributes(MenuItem item) {
			weak string label_text = item.get_label();
			if(label_text != null) {
				sb.append_printf(" label=\"%s\"",
					Markup.escape_text(label_text, -1));
			}
		}

		private StringBuilder sb;
		private int level;
		private bool _newline;
		private bool pretty_print;

		private void indent() {
			if(!pretty_print) return;
			if(_newline) {
				for(int i = 0; i < level; i++)
					sb.append_c(' ');
				_newline = false;
			}
		}
		private void newline() {
			if(!pretty_print) return;
			sb.append_c('\n');	
			_newline = true;
		}
	}

}
