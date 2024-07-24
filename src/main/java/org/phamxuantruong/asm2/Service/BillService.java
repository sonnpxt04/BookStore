package org.phamxuantruong.asm2.Service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.hibernate.Session;

import org.phamxuantruong.asm2.Interface.BillDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BillService {
    @PersistenceContext
    private EntityManager entityManager;
    public Double calculateTotalRevenue() {
        try {
            // HQL query to calculate total revenue
            String hql = "SELECT SUM(b.total) FROM Bill b";
            Query query = entityManager.createQuery(hql);
            Double totalRevenue = (Double) query.getSingleResult();
            if (totalRevenue == null) {
                return 0.0; // Return 0 if there are no records
            } else {
                return totalRevenue;
            }
        } finally {
            entityManager.close();
        }
    }
    public Map<String, Double> calculateRevenueByMonth() {
        Map<String, Double> revenueByMonth = new LinkedHashMap<>();

        // Tạo truy vấn HQL để lấy tổng doanh thu theo từng tháng
        String hql = " SELECT MONTH(b.orderDate) AS Month,\n" +
                "       SUM(b.total) AS Total\n" +
                "FROM Bill b\n" +
                "GROUP BY MONTH(b.orderDate)\n";


        // Thực hiện truy vấn
        List<Object[]> results = entityManager.createQuery(hql).getResultList();

        // Xử lý kết quả trả về
        for (Object[] result : results) {
            Integer month = (Integer) result[0];
            String monthYear = month.toString();

            Double totalRevenue = (Double) result[1];
            revenueByMonth.put(monthYear, totalRevenue);
        }

        return revenueByMonth;
    }

}
