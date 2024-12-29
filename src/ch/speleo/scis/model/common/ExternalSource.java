package ch.speleo.scis.model.common;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.envers.Audited;
import org.openxava.annotations.Depends;
import org.openxava.annotations.DisplaySize;
import org.openxava.annotations.Hidden;
import org.openxava.annotations.PreDelete;
import org.openxava.annotations.Required;
import org.openxava.annotations.RowStyle;
import org.openxava.annotations.Tab;
import org.openxava.annotations.View;
import org.openxava.annotations.Views;

import ch.speleo.scis.persistence.audit.ScisUserUtils;
import ch.speleo.scis.persistence.audit.ScisUserUtils.ScisRole;
import lombok.Getter;
import lombok.Setter;

/**
 * An external information system used locally, such as AGH-DB or a club database, that gives identifiers.
 */
@Entity
@Table(name = "EXTERNAL_SOURCE",
    uniqueConstraints = {
            @UniqueConstraint(columnNames = "CODE", name = "EXTERNAL_SOURCE_CODE_UNIQUE"),
			@UniqueConstraint(columnNames = "NAME", name = "EXTERNAL_SOURCE_NAME_UNIQUE")}
	)
@Audited
@Tab(properties = "code, name", 
	rowStyles = {@RowStyle(style="deletedData", property="deleted", value="true")})
@Views({
	@View(name = "Short", members = "code, name"), 
	@View(name = "SpeleoObject", members = "code, name"), 
	@View(members = "code; name")
})
@Getter @Setter
public class ExternalSource 
extends GenericIdentityWithDeleted implements Serializable, Identifiable {

	private static final long serialVersionUID = 5622141359056128822L;
    
    /**
     * Unique code.
     */
    @Required
    @Column(name = "CODE", nullable = false, length=10)
	@DisplaySize(value=8, forViews="SpeleoObject") 
    private String code;
    
    @Required
    @Column(name = "NAME", nullable = false, length=100)
	@DisplaySize(value=25, forViews="Short") 
	@DisplaySize(value=50, forViews="SpeleoObject") 
    private String name;
    
	@Depends("code")
	@Hidden
	public String getBusinessId() {
		return getCode();
	}

	@PrePersist @PreUpdate @PreDelete
    public void handlePermissionsOnWrite() {
        ScisUserUtils.checkRoleInCurrentUser(ScisRole.SGH_ARCHIVAR);
    }
    
	@Override
	protected void writeFields(StringBuilder builder) {
		super.writeFields(builder);
		builder.append(", code=");
		builder.append(code);
		builder.append(", name=");
		builder.append(name);
	}

}
