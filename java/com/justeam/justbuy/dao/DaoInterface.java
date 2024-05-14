package com.justeam.justbuy.dao;

import java.util.List;

public interface DaoInterface <T>{

	public void create(T ref);
	public List<T> retrieveAll();
	public void update(T ref);
	public void delete(T ref);

}