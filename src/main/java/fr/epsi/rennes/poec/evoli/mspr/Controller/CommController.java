package fr.epsi.rennes.poec.evoli.mspr.Controller;

import fr.epsi.rennes.poec.evoli.mspr.domain.Customer;
import fr.epsi.rennes.poec.evoli.mspr.domain.Response;
import fr.epsi.rennes.poec.evoli.mspr.exception.BusinessException;
import fr.epsi.rennes.poec.evoli.mspr.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 6/5/2022 : 12:07 AM:47
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.Controller
 * Project name : acme MSPR
 **/

@RestController
public class CommController {
    @Autowired
    CustomerService customerService;
    // todo: accessibility upgrades
    //       Ease country input
    //       Ease Address input using google map api ?

    //    @Autowired
    //    MapService mapService;

    @PostMapping("/comm/customer/modify")
    public Response<Void> modifyCustomer(@RequestBody Customer customer) throws BusinessException {
        Response<Void> response = new Response<>();
        if (customerService.modifyCustomer(customer) == -1) {
            response.setSuccess(false);
            throw new BusinessException(" : : : could not retrieve ");
        } else {
            response.setSuccess(true);
        }
        return response;
    }
    @PostMapping("/comm/customer/add")
    public Response<Void> addCustomer(@RequestBody Customer customer) throws BusinessException {
        Response<Void> response = new Response<>();
        if (customerService.addCustomer(customer) == -1) {
            response.setSuccess(false);
            throw new BusinessException(" : : : could not retrieve ");
        } else {
            response.setSuccess(true);
        }
        return response;
    }
    @PostMapping("/comm/customer/remove")
    public Response<Void> removeCustomer(@RequestBody Customer customer) throws BusinessException {
        Response<Void> response = new Response<>();
        if (customerService.remCustomer(customer.getId()) == -1) {
            response.setSuccess(false);
            throw new BusinessException(" : : : could not retrieve ");
        } else {
            response.setSuccess(true);
        }
        return response;
    }
    @GetMapping("/comm/customers")
    public Response<List<Customer>> getAllCustomers() throws BusinessException {
        Response<List<Customer>> response = new Response<>();
        response.setData(customerService.getAllCustomers());
        if (response.getData() == null) {
            response.setSuccess(false);
            throw new BusinessException("could not retrieve customers");
        } else {
            response.setSuccess(true);
        }
        return response;
    }
}
