package test;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import net.sf.cglib.beans.BeanGenerator;
import net.sf.cglib.beans.BeanMap;

public class DynamicBean {

	/**
	 * 实体Object
	 */
	private Object object = null;

	/**
	 * 属性map
	 */
	private BeanMap beanMap = null;

	public DynamicBean() {
		super();
	}

	@SuppressWarnings("unchecked")
	public DynamicBean(Map propertyMap) {
		this.object = generateBean(propertyMap);
		this.beanMap = BeanMap.create(this.object);
	}

	/**
	 * 给bean属性赋值
	 * 
	 * @param property
	 *            属性名
	 * @param value
	 *            值
	 */
	public void setValue(String property, Object value) {
		beanMap.put(property, value);
	}

	/**
	 * 通过属性名得到属性值
	 * 
	 * @param property
	 *            属性名
	 * @return 值
	 */
	public Object getValue(String property) {
		return beanMap.get(property);
	}

	/**
	 * 得到该实体bean对象
	 * 
	 * @return
	 */
	public Object getObject() {
		return this.object;
	}

	/**
	 * @param propertyMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Object generateBean(Map propertyMap) {
		BeanGenerator generator = new BeanGenerator();
		Set keySet = propertyMap.keySet();
		for (Iterator i = keySet.iterator(); i.hasNext();) {
			String key = (String) i.next();
			generator.addProperty(key, (Class) propertyMap.get(key));
		}
		return generator.create();
	}

	public static void main(String[] args) throws ClassNotFoundException {

		// 设置类成员属性
		HashMap propertyMap = new HashMap();

		propertyMap.put("id", Class.forName("java.lang.Integer"));

		propertyMap.put("name", Class.forName("java.lang.String"));

		propertyMap.put("address", Class.forName("java.lang.String"));

		// 生成动态 Bean
		DynamicBean bean = new DynamicBean(propertyMap);

		// 给 Bean 设置值
		bean.setValue("id", new Integer(123));

		bean.setValue("name", "454");

		bean.setValue("address", "789");

		// 从 Bean 中获取值，当然了获得值的类型是 Object

		// System.out.println(" >> id = " + bean.getValue("id"));

		// System.out.println(" >> name = " + bean.getValue("name"));

		// System.out.println(" >> address = " + bean.getValue("address"));

		// 获得bean的实体
		Object object = bean.getObject();

		// 通过反射查看所有方法名
		Class clazz = object.getClass();
		Method[] methods = clazz.getDeclaredMethods();
		for (int i = 0; i < methods.length; i++) {
			// System.out.println(methods[i].getName());
		}
	}

}
