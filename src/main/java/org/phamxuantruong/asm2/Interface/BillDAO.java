package org.phamxuantruong.asm2.Interface;

import org.phamxuantruong.asm2.Entity.Bill;
import org.phamxuantruong.asm2.Entity.Categories;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BillDAO extends JpaRepository<Bill, Long> {
//    List<Bill> findByCartId(Long cartId);
Page<Bill> findByFullnameContaining(String fullname, Pageable pageable);

    Page<Bill> findByUserUsernameAndFullnameContaining(String username, String fullname, Pageable pageable);

}
