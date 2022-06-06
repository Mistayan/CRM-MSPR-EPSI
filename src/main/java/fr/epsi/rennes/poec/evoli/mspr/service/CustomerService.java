package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.CustomerDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Customer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 6/5/2022 : 12:35 AM:53
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : acme MSPR
 **/

@Service
public class CustomerService {
    private static final Logger logger = LogManager.getLogger(CustomerService.class);
    @Autowired
    private final CustomerDAO customerDAO;

    public CustomerService(CustomerDAO customerDAO) {this.customerDAO = customerDAO;}


    public int addCustomer(Customer customer) {
        return customerDAO.addCustomer(customer);
    }

    @Transactional
    public int remCustomer(int customerId) {
        return customerDAO.switchCustomer(customerId, false);
    }

    @Transactional
    public int modifyCustomer(Customer customer) {
        return customerDAO.modifyCustomer(customer);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    public List<Customer> getAllCustomersPublic() {
        return customerDAO.getAllCustomersPublic();
    }
}
