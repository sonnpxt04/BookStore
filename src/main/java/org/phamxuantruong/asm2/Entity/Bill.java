package org.phamxuantruong.asm2.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Bill")
public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long BillID;

    @ManyToOne
    @JoinColumn(name = "Username", referencedColumnName = "username")
    private Users user;

    @Column(name = "order_date")
    @Temporal(TemporalType.DATE)
    private Date orderDate;

    @Column(name = "Address", length = 255)
    private String address;

    @Column(name = "Fullname", length = 50)
    private String fullname;

    @Column(name = "Email", length = 50)
    private String email;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @Column(name = "payment_method", length = 50)
    private String paymentMethod;

    @Column(name = "Total")
    private Double total;

    private String action;
    @PrePersist
    protected void onCreate() {
        if (this.action == null) {
            this.action = "Chờ xác nhận";
        }
    }
}
