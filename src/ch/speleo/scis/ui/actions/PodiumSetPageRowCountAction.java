package ch.speleo.scis.ui.actions;

import org.openxava.actions.BaseAction;

public class PodiumSetPageRowCountAction extends BaseAction {
	
	public static final String ATTRIBUTE_NAME = "scis_podium_rowCount";
	private int rowCount;
	
	public void execute() throws Exception {
		getRequest().setAttribute(ATTRIBUTE_NAME, getRowCount());
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public int getRowCount() {
		return rowCount;
	}

}
