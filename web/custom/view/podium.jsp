<%@ include file="../../xava/imports.jsp"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.apache.commons.lang.ObjectUtils"%>
<%@ page import="org.openxava.util.Labels"%>
<%@ page import="org.openxava.web.Ids"%>
<%@ page import="ch.speleo.scis.model.karst.SpeleoObject"%>
<%@ page import="ch.speleo.scis.business.Podium"%>
<%@ page import="ch.speleo.scis.ui.actions.PodiumSetPageRowCountAction"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>

	<%
	Integer nbCaves = (Integer) request.getAttribute(PodiumSetPageRowCountAction.ATTRIBUTE_NAME);
	%>
	<%-- inspired by listEditor.jsp --%>
	<select id="<xava:id name='all_rowCount'/>" class="editor"
		onchange="openxava.executeAction('<%=request.getParameter("application")%>', '<%=request.getParameter("module")%>', '', false, 'PodiumScis.setPageRowCount', 'rowCount=' + this.value)">
		<% 
		int [] rowCounts = { Podium.NB_RESULT_PER_DEFAULT, 20, 50, Podium.NB_RESULT_MAX };
		for (int i=0; i<rowCounts.length; i++) {
			String selected = (nbCaves != null && rowCounts[i] == nbCaves) ? "selected='selected'" : ""; 	
		%>	
		<option value="<%=rowCounts[i]%>" <%=selected %>><%=rowCounts[i]%></option>
		<%
		}
		%>
	</select>
	<span class="rows-per-page">	 
		<xava:message key="rows_per_page"/>
	</span>

	<%
	Podium podiumService = new Podium();
	Locale locale = new Locale("de", "CH");
	%>

	<h2><xava:message key="deepest_caves" /></h2>
	<table class="podium ox-list">
		<tr class="results-header portlet-section-header ox-list-header">
			<th align="right"><xava:message key="place" /></th>
			<th align="left" ><xava:label key="name" /></th>
			<th align="right"><xava:label key="depthAndElevation" /></th>
			<th align="right"><xava:label key="systemNr" /></th>
		</tr>
		<%
		List<SpeleoObject> deepestCaves = podiumService.getDeepestCaves(nbCaves);
		int iDeepest=0;
		for (SpeleoObject cave: deepestCaves) {
			String styleClass = "results-row " + ((0==iDeepest%2)?"portlet-section-body":"portlet-section-alternate alt");
			iDeepest++;
		%>
		<tr class="<%= styleClass %>">
			<td align="right"><%= iDeepest %></td>
			<td align="left" ><%= ObjectUtils.toString(cave.getName(), "") %></td>
			<td align="right"><%= String.format(locale, "%,d", cave.getDepthAndElevationComputed()) %></td>
			<td align="right"><%= ObjectUtils.toString(cave.getSystemNr(), "") %></td>
		</tr>
		<%
		}
		%>
	</table>

	<h2><xava:message key="longest_caves" /></h2>
	<table class="podium ox-list">
		<tr class="results-header portlet-section-header ox-list-header">
			<th align="right"><xava:message key="place" /></th>
			<th align="left" ><xava:label key="name" /></th>
			<th align="right"><xava:label key="length" /></th>
			<th align="right"><xava:label key="systemNr" /></th>
		</tr>
		<%
		List<SpeleoObject> longestCaves = podiumService.getLongestCaves(nbCaves);
		int iLongest=0;
		for (SpeleoObject cave: longestCaves) {
			String styleClass = "results-row " + ((0==iLongest%2)?"portlet-section-body":"portlet-section-alternate alt");
			iLongest++;
		%>
		<tr class="<%= styleClass %>" style="border-bottom: 1px solid;">
			<td align="right"><%= iLongest %></td>
			<td align="left" ><%= ObjectUtils.toString(cave.getName(), "") %></td>
			<td align="right"><%= String.format(locale, "%,d", cave.getLength()) %></td>
			<td align="right"><%= ObjectUtils.toString(cave.getSystemNr(), "") %></td>
		</tr>
		<%
		}
		%>
	</table>

